#!/bin/bash
#
# This script assumes Docker Desktop is already installed on the user's machine.
# It *does not* assume any specific docker credentials are loaded, and instead uses
# service account credentials provided by VMware for uploading images if needed.

VARIANT="$(uname -sm | tr 'A-Z ' 'a-z-' | sed s/aarch64/arm64/ | sed s/x86_64/amd64/)"
FUNC_VARIANT="$(echo $VARIANT | tr '-' '_')"

mkdir -p $HOME/.bin
cd $HOME/.bin

echo "Downloading kn and kn-plugin-func for $VARIANT" 1>&2

curl -L -o kn "https://github.com/knative/client/releases/download/knative-v1.2.0/kn-$VARIANT" >&/dev/null
curl -L -o kn-plugin-func "https://github.com/knative-sandbox/kn-plugin-func/releases/download/v0.22.0/func_$FUNC_VARIANT" >&/dev/null

chmod +x kn kn-plugin-func
ln -s kn-plugin-func func

echo "Installed plugins" 1>&2

echo 'export PATH="${PATH}:${HOME}/.bin"' >> ${HOME}/.profile

echo ". ${HOME}/.profile"
