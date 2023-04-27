# AI Robot Desktop

> **Note:** This project is privately hosted on GitLab at [coarobo/workspaces/ai-robot-book/ai-robot-desktop](https://gitlab.com/coarobo/workspaces/ai-robot-book/ai-robot-desktop) for development and publicly mirrored on GitHub at [coarobo/ai-robot-desktop](https://github.com/coarobo/ai-robot-desktop) for usage.
> Only developers with write access to the repository on GitLab can push new code or images.

AI Robot Desktop enables users to run ROS 2 simulations inside a Docker container via a VNC desktop.
This repository was forked from [AI-Robot-Book/docker-ros2-desktop-ai-robot-book](https://github.com/AI-Robot-Book/docker-ros2-desktop-ai-robot-book) that provides a containerized environment and teaching materials for the book *｢ROS2とPythonで作って学ぶAIロボット入門｣* (also known as *"AI Robot Book"*) published by Kodansha and written by Kosei Demura, Yoshinobu Hagiwara, Yasuhiro Masutani, and Jeffrey Too Chuan Tan.
This fork, renamed `ai-robot-desktop`, brings minor corrections and enhancements made by [Coarobo GK](https://coarobo.com/) for deploying the original materials in a cloud environment.

## Original Work

> **Note:** The content below is retrieved from the time of forking [AI-Robot-Book/docker-ros2-desktop-ai-robot-book](https://github.com/AI-Robot-Book/docker-ros2-desktop-ai-robot-book) at commit [`ed9bbe1420`](https://github.com/AI-Robot-Book/docker-ros2-desktop-ai-robot-book/tree/ed9bbe1420c790f4934ea0d9bb0918cd969d907f).

**Original license:**
*   `LICENSE`: [AI-Robot-Book/docker-ros2-desktop-ai-robot-book/LICENSE](https://github.com/AI-Robot-Book/docker-ros2-desktop-ai-robot-book/blob/ed9bbe1420c790f4934ea0d9bb0918cd969d907f/LICENSE)

**Original documentation:**
*   `README.md`: [AI-Robot-Book/docker-ros2-desktop-ai-robot-book/README.md](https://github.com/AI-Robot-Book/docker-ros2-desktop-ai-robot-book/blob/ed9bbe1420c790f4934ea0d9bb0918cd969d907f/README.md)
*   `README-original.md`: [AI-Robot-Book/docker-ros2-desktop-ai-robot-book/README-original.md](https://github.com/AI-Robot-Book/docker-ros2-desktop-ai-robot-book/blob/ed9bbe1420c790f4934ea0d9bb0918cd969d907f/README-original.md)
*   `ARCHITECTURE.md`: [AI-Robot-Book/docker-ros2-desktop-ai-robot-book/ARCHITECTURE.md](https://github.com/AI-Robot-Book/docker-ros2-desktop-ai-robot-book/blob/ed9bbe1420c790f4934ea0d9bb0918cd969d907f/ARCHITECTURE.md)
*   `DEVELOPMENT.md`: [AI-Robot-Book/docker-ros2-desktop-ai-robot-book/DEVELOPMENT.md](https://github.com/AI-Robot-Book/docker-ros2-desktop-ai-robot-book/blob/ed9bbe1420c790f4934ea0d9bb0918cd969d907f/DEVELOPMENT.md)

## Initial Setup

1.  Clone the Git repository:
    1.  If you are a user, clone the Git repository from GitHub (public access):
        ```bash
        git clone --recursive https://github.com/coarobo/ai-robot-desktop.git
        ```
    1.  If you are a developer, clone the Git repository from GitLab (private access):
        ```bash
        git clone --recursive https://gitlab.com/coarobo/workspaces/ai-robot-book/ai-robot-desktop.git
        ```
2.  Pull the `latest` image from the Docker registry on GitLab (public access):
    ```bash
    docker login -u "gitlab+deploy-token-1977716" -p "SCh-JaCU2cdHoaQ6_YHY" registry.gitlab.com/coarobo/workspaces/ai-robot-book/ai-robot-desktop
    docker pull registry.gitlab.com/coarobo/workspaces/ai-robot-book/ai-robot-desktop/ai-robot-image:latest
    ```
3.  Run the Docker container:
    ```bash
    cd ai-robot-desktop/
    ./run.bash
    ```
4.  Connect to the VNC desktop: [http://localhost:6080](http://localhost:6080)

## Image Build

> **Note:** The image was last built and tested on Ubuntu 20.04 LTS on April 23, 2023.

1.  Clone the Git repository:
    1.  If you are a user, clone the Git repository from GitHub (public access):
        ```bash
        git clone --recursive https://github.com/coarobo/ai-robot-desktop.git
        ```
    1.  If you are a developer, clone the Git repository from GitLab (private access):
        ```bash
        git clone --recursive https://gitlab.com/coarobo/workspaces/ai-robot-book/ai-robot-desktop.git
        ```
2.  Build the Docker image:
    ```bash
    cd ai-robot-desktop/
    ./build.bash
    ```
3.  Push a newer `latest` image to the Docker registry on GitLab (private access):
    ```bash
    docker login registry.gitlab.com/coarobo/workspaces/ai-robot-book/ai-robot-desktop
    docker push registry.gitlab.com/coarobo/workspaces/ai-robot-book/ai-robot-desktop/ai-robot-image:latest
    ```
