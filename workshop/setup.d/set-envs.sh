#!/bin/sh
#
# Load necessary environment variables

cat >> $HOME/.profile <<EOF
export PATH="${PATH}:${HOME}/.bin"
export SSL_CERT_DIR="${HOME}/.docker/certs.d/registry.20.118.148.208.nip.io"
