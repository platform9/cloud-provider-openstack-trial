#!/bin/bash

set -o nounset
set -o errexit
set -o pipefail
set -x

echo -e '/host/lib64\n/host/usr/lib64' > /etc/ld.so.conf.d/x86_64-linux-gnu.conf
ln -s /host/lib/x86_64-linux-gnu/libisns-nocrypto.so.0 /lib/x86_64-linux-gnu/libisns-nocrypto.so.0
ldconfig

/bin/cinder-csi-plugin \
  --endpoint="$(echo "${CSI_ENDPOINT}" | xargs)" \
  --cloud-config="$(echo "${CLOUD_CONFIG}" | xargs)" \
  --v=5