#!/bin/bash
docker build \
$* \
--progress=plain \
--build-arg http_proxy=$http_proxy \
--build-arg https_proxy=$https_proxy \
-t fcwu-test \
.