#!/usr/bin/env sh

SCRIPT_PATH=$(realpath "$0")
SRC_DIR_PATH=$(dirname "$SCRIPT_PATH")
LIB_DIR_PATH="${SRC_DIR_PATH}/lib"

. "${LIB_DIR_PATH}/logging.sh"

get_url() {
  minor_version="$(echo "${1}" | cut -b1- | cut -b-3)"
  case "${minor_version}" in
    "4.0")
      echo "https://sourceforge.net/projects/open-cobol/files/gnu-cobol/nightly_snapshots/gnucobol-${input_version}-early-dev.tar.gz"
      ;;
    "3.3")
      echo "https://sourceforge.net/projects/open-cobol/files/gnu-cobol/nightly_snapshots/gnucobol-${input_version}-dev.tar.gz"
      ;;
    *)
      echo "https://sourceforge.net/projects/open-cobol/files/gnu-cobol/${minor_version}/gnucobol-${input_version}.tar.gz"
      ;;
  esac
}

main() {
  input_version="${1}"
  bin_path="${2}"

  sudo apt-get update
  sudo apt-get -y install curl tar libncurses5-dev libgmp-dev libdb-dev
  sudo apt-get -y autoremove
  sudo apt-get -y install iproute2

  # download and install open-cobol for dependencies (libcob >= 4.0)
  sudo apt-get -y install ranger autoconf build-essential

  mkdir -p "${bin_path}"
  url="$(get_url "${input_version}")"
  log_info "Downloading ${url}"
  curl -sLk "${url}" -o "${bin_path}/gnucobol.tar.gz"
  tar -xvf "${bin_path}/gnucobol.tar.gz" -C "${bin_path}" --strip-components 1
  rm -f "${bin_path}/gnucobol.tar.gz"
  cd "${bin_path}" \
    && ./configure --prefix=/usr \
    && sudo make \
    && sudo make install \
    && sudo ldconfig \
    && cd /tmp/ \
    && sudo rm -rf ./*
  sudo apt-get -y --purge autoremove

  echo "/home/cobol" >> "$GITHUB_PATH"
}

main "$@"
