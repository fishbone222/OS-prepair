. /etc/os-release
if [[ ! " 8.6 8.8 8.9 9.0 9.2 9.3 " =~ " ${VERSION_ID} " ]]; then
  echo "RHEL version ${VERSION_ID} not supported"
else
  echo "Installing online network repository for ${VERSION_ID}"
  sudo dnf install -y 'dnf-command(config-manager)'
  sudo dnf config-manager --add-repo \
    https://repositories.intel.com/gpu/rhel/${VERSION_ID}/lts/2350/unified/intel-gpu-${VERSION_ID}.repo
fi
