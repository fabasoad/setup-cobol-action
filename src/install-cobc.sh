#!/usr/bin/env bash

main() {
  input_version="${1}"
  bin_path="${2}"

  sudo apt-get update
  sudo apt-get -y install curl tar libncurses5-dev libgmp-dev libdb-dev
  sudo apt-get -y autoremove
  sudo apt-get -y install iproute2

  # download and install open-cobol for dependencies (libcob >= 4.0)
  sudo apt-get -y install ranger autoconf build-essential

  minor_version="$(echo "${input_version}" | cut -b1- | cut -b-3)"
  url="https://sourceforge.net/projects/open-cobol/files/gnu-cobol/${minor_version}/gnucobol-${input_version}.tar.gz"
  curl -sLk "${url}" -o "${bin_path}/gnucobol.tar.gz"
  tar -xvf "${bin_path}/gnucobol.tar.gz" -C "${bin_path}"
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
