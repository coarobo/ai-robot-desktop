#!/bin/bash

#デバッグ用
#set -vx

update-locale LANG=ja_JP.UTF-8

export LANG=ja_JP.UTF-8
export TZ=Asia/Tokyo

if [ -n "$VNC_PASSWORD" ]; then
    echo -n "$VNC_PASSWORD" > /.password1
    x11vnc -storepasswd $(cat /.password1) /.password2
    chmod 400 /.password*
    sed -i 's/^command=x11vnc.*/& -rfbauth \/.password2/' /etc/supervisor/conf.d/supervisord.conf
    export VNC_PASSWORD=
fi

if [ -n "$X11VNC_ARGS" ]; then
    sed -i "s/^command=x11vnc.*/& ${X11VNC_ARGS}/" /etc/supervisor/conf.d/supervisord.conf
fi

if [ -n "$OPENBOX_ARGS" ]; then
    sed -i "s#^command=/usr/bin/openbox\$#& ${OPENBOX_ARGS}#" /etc/supervisor/conf.d/supervisord.conf
fi

if [ -n "$RESOLUTION" ]; then
    sed -i "s/1024x768/$RESOLUTION/" /usr/local/bin/xvfb.sh
fi

USER=${USER:-root}
HOME=/root
if [ "$USER" == "ubuntu" ]; then
    HOME=/home/$USER
    cp -r /root/{.gtkrc-2.0,.asoundrc} ${HOME}
    [ -d "/dev/snd" ] && chgrp -R adm /dev/snd
elif [ "$USER" != "root" ]; then
    echo "* enable custom user: $USER"
    useradd --create-home --shell /bin/bash --user-group --groups adm,sudo $USER
    if [ -z "$PASSWORD" ]; then
        echo "  set default password to \"ubuntu\""
        PASSWORD=ubuntu
    fi
    HOME=/home/$USER
    echo "$USER:$PASSWORD" | chpasswd
    cp -r /root/{.config,.gtkrc-2.0,.asoundrc} ${HOME}
    chown -R $USER:$USER ${HOME}
    [ -d "/dev/snd" ] && chgrp -R adm /dev/snd
fi
sed -i -e "s|%USER%|$USER|" -e "s|%HOME%|$HOME|" /etc/supervisor/conf.d/supervisord.conf

cat << EOF > ${HOME}/.xsession
pulseaudio -D --enable-memfd=True
export TZ=${TZ}
export http_proxy=${http_proxy}
export https_proxy=${https_proxy}
export HTTP_PROXY=${HTTP_PROXY}
export HTTPS_PROXY=${HTTPS_PROXY}
lxsession -s LXDE -e LXDE
EOF
chown -R $USER:$USER ${HOME}/.xsession

# Error No session for pid XXXX の回避のためlxpolkitを無効化
mv /bin/lxpolkit /bin/lxpolkit.bak

# home folder
if [ ! -x "$HOME/.config/pcmanfm/LXDE/" ]; then
    mkdir -p $HOME/.config/pcmanfm/LXDE/
    ln -sf /usr/local/share/doro-lxde-wallpapers/desktop-items-0.conf $HOME/.config/pcmanfm/LXDE/
    chown -R $USER:$USER $HOME/.config/pcmanfm/LXDE
fi

# nginx workers
sed -i 's|worker_processes .*|worker_processes 1;|' /etc/nginx/nginx.conf

# nginx ssl
if [ -n "$SSL_PORT" ] && [ -e "/etc/nginx/ssl/nginx.key" ]; then
    echo "* enable SSL"
	sed -i 's|#_SSL_PORT_#\(.*\)443\(.*\)|\1'$SSL_PORT'\2|' /etc/nginx/sites-enabled/default
	sed -i 's|#_SSL_PORT_#||' /etc/nginx/sites-enabled/default
fi

# nginx http base authentication
if [ -n "$HTTP_PASSWORD" ]; then
    echo "* enable HTTP base authentication"
    htpasswd -bc /etc/nginx/.htpasswd $USER $HTTP_PASSWORD
	sed -i 's|#_HTTP_PASSWORD_#||' /etc/nginx/sites-enabled/default
fi

# dynamic prefix path renaming
if [ -n "$RELATIVE_URL_ROOT" ]; then
    echo "* enable RELATIVE_URL_ROOT: $RELATIVE_URL_ROOT"
	sed -i 's|#_RELATIVE_URL_ROOT_||' /etc/nginx/sites-enabled/default
	sed -i 's|_RELATIVE_URL_ROOT_|'$RELATIVE_URL_ROOT'|' /etc/nginx/sites-enabled/default
fi
# generate xrdp key
if [ ! -f "/etc/xrdp/rsakeys.ini" ];
	then
		xrdp-keygen xrdp auto
fi

# generate certificate for tls connection
if [ ! -f "/etc/xrdp/cert.pem" ];
	then
		# delete eventual leftover private key
		rm -f /etc/xrdp/key.pem || true
		cd /etc/xrdp
		if [ ! $CERTIFICATE_SUBJECT ]; then
			CERTIFICATE_SUBJECT="/C=US/ST=Some State/L=Some City/O=Some Org/OU=Some Unit/CN=Terminalserver"
		fi
		openssl req -x509 -newkey rsa:2048 -nodes -keyout /etc/xrdp/key.pem -out /etc/xrdp/cert.pem -days 365 -subj "$CERTIFICATE_SUBJECT"
		crudini --set /etc/xrdp/xrdp.ini Globals security_layer tls
		crudini --set /etc/xrdp/xrdp.ini Globals certificate /etc/xrdp/cert.pem
		crudini --set /etc/xrdp/xrdp.ini Globals key_file /etc/xrdp/key.pem

fi

# generate machine-id
uuidgen > /etc/machine-id

# clearup
PASSWORD=
HTTP_PASSWORD=

### 別の場所で設定すべきかも
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export DefaultIMModule=fcitx
###

cat << EOF >> /etc/supervisor/conf.d/supervisord.conf

[program:fcitx]
priority=30
directory=$HOME
command=fcitx -D
user=$USER
environment=DISPLAY=":1",HOME="$HOME",USER="$USER"
EOF

exec /bin/tini -- supervisord -n -c /etc/supervisor/supervisord.conf
