#!/bin/sh
#
# This script assumes Docker Desktop is already installed on the user's machine.
# It *does not* assume any specific docker credentials are loaded, and instead uses
# service account credentials provided by VMware for uploading images if needed.

VARIANT="$(uname -sm | tr 'A-Z ' 'a-z-' | sed s/aarch64/arm64/ | sed s/x86_64/amd64/)"
FUNC_VARIANT="$(echo $VARIANT | tr '-' '_')"

mkdir -p $HOME/.bin
cd $HOME/.bin

echo "Downloading kn and kn-plugin-func for $VARIANT"

curl -L -o kn https://github.com/knative/client/releases/download/knative-v1.2.0/kn-$VARIANT >&/dev/null
curl -L -o kn-plugin-func https://github.com/knative-sandbox/kn-plugin-func/releases/download/v0.22.0/func_$FUNC_VARIANT >&/dev/null

chmod +x kn kn-plugin-func
ln -s kn-plugin-func func

echo "Installed plugins"

echo 'export PATH=${PATH}:${HOME}/.bin'

# Load the CA certificate for the private registry

echo "Loading registry cert"

cat > $HOME/.docker/certs.d/registry.20.118.148.208.nip.io/ca.crt <<EOF
-----BEGIN CERTIFICATE-----
MIIDCTCCAfGgAwIBAgIRAIiLJ7aFUrIx7+zcDaxi1nkwDQYJKoZIhvcNAQELBQAw
HjEcMBoGA1UEAxMTcmVnaXN0cnktc2VsZnNpZ25lZDAeFw0yMjAzMTQxODA4MzBa
Fw0yMjA2MTIxODA4MzBaMB4xHDAaBgNVBAMTE3JlZ2lzdHJ5LXNlbGZzaWduZWQw
ggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDOO2VWqT7LNnwUalO7CqFG
eVNjLAQKeI0q5UDpuCsvOFn72SHY2817/cqWd8nRjy+SWghPei642Km5s/F+NeCU
rWmbRwQhOFaebwxFoGKfVewnYyR+pUbJxboSDJoHIc4S58wgptgqf23OKCO2T2KL
s9XQtZMVw3wzh3q0yLzhsXdIyLlxbwNZPr+92EUrTeJLKIKcgEVRukEbPRkaOjD4
QopwmbchBCHfNHKyEj/x0DW1DVCxuJni9cCgL4iC1hFtpbiqXJKvh7WaD3I/oN7s
RpOrOdHDEDGHisnSn87CAg/xoocyWCA38nmkjXDGMNpx8naYq2TLHDqKEGeD+2mZ
AgMBAAGjQjBAMA4GA1UdDwEB/wQEAwICpDAPBgNVHRMBAf8EBTADAQH/MB0GA1Ud
DgQWBBTCqKA+E/5GJjhLy3idWupaPjS+GjANBgkqhkiG9w0BAQsFAAOCAQEAyE2R
Bdr4kMk73MWcYO9UVkHjnjhTlCEGiZAOYmrfFp9suqzRyIgVmEXu16U4uA1vxGX6
JoCWQho51i5jnHQDKM9QIp9ObQvFO3dTfMxAEK84fCYDau/J56ksbKHXZsBBNTfo
BmSMcVPICp1RM9bFJ8ajFk7E3Y+VOjZh5Ajtsn7E+colZsww4Fs+Fc8VGAmBYmsy
t4HTrRYZyGxBKn2yuRegZ0EZ8tdg4XQLAbQwl9Dt7XdNgQBqV6h3jF7Vfvj7u5pk
S3aE8ySUyJFDYp13IJwLVWu3xGvtWLeTjbagXP2rthVHgep8+bB4XPjPVirErAWK
rIP+pyewWkdxUAHoMg==
-----END CERTIFICATE-----
EOF

echo 'export SSL_CERT_DIR=${HOME}/.docker/certs.d/registry.20.118.148.208.nip.io'
