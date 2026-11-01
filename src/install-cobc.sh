#!/usr/bin/env sh
set -e

SCRIPT_PATH=$(realpath "$0")
SRC_DIR_PATH=$(dirname "$SCRIPT_PATH")
LIB_DIR_PATH="${SRC_DIR_PATH}/lib"

. "${LIB_DIR_PATH}/logging.sh"

main() {
  input_version="${1}"
  bin_path="${2}"
  minor_version="$(echo "${input_version}" | cut -b1- | cut -b-3)"

  sudo apt-get update
  if [ "${minor_version}" = "4.0" ]; then
    log_info "Installing cobc ${minor_version} from the apt-get"
    sudo apt-get install -y gnucobol4
    exit 0
  fi

  log_info "Installing cobc ${minor_version} from the source code"
  sudo apt-get -y install curl tar libncurses5-dev libgmp-dev libdb-dev
  sudo apt-get -y autoremove
  sudo apt-get -y install iproute2

  # download and install open-cobol for dependencies (libcob >= 4.0)
  sudo apt-get -y install ranger autoconf build-essential

  mkdir -p "${bin_path}"
  url="https://sourceforge.net/projects/open-cobol/files/gnucobol/${minor_version}/gnucobol-${input_version}.tar.gz"
  log_info "Downloading ${url}"
  curl -fsLk "${url}" -o "${bin_path}/gnucobol.tar.gz"
  tar -xvf "${bin_path}/gnucobol.tar.gz" -C "${bin_path}" --strip-components 1
  rm -f "${bin_path}/gnucobol.tar.gz"
  # GnuCOBOL 3.x predates GCC 14, which promoted implicit function
  # declarations and incompatible pointer assignments to errors and switched
  # the default language to C23. Relax both so the sources keep building on
  # newer runner images (e.g. Ubuntu 26.04 with GCC 15).
  cflags="-O2 -std=gnu17"
  cflags="${cflags} -Wno-error=implicit-function-declaration"
  cflags="${cflags} -Wno-error=incompatible-pointer-types"

  cd "${bin_path}"
  ./configure --prefix=/usr CFLAGS="${cflags}"
  sudo make
  sudo make install
  sudo ldconfig
  sudo apt-get -y --purge autoremove

  echo "/home/cobol" >> "$GITHUB_PATH"
}

main "$@"
