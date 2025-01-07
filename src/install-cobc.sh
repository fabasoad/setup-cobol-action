#!/usr/bin/env bash

main() {
  input_version="${1}"

  sudo apt-get update
  sudo apt-get -y install curl tar libncurses5-dev libgmp-dev libdb-dev
  sudo apt-get -y autoremove
  sudo apt-get -y install iproute2

  # download and install open-cobol for dependencies (libcob >= 4.0)
  sudo apt-get -y install ranger autoconf build-essential
  curl -sLk https://sourceforge.net/projects/open-cobol/files/gnu-cobol/"$(echo "${input_version}" | cut -b1- | cut -b-3)"/gnucobol-"${input_version}".tar.gz | tar xz
  cd gnucobol-"${input_version}" && ./configure --prefix=/usr && sudo make && sudo make install && sudo ldconfig && cd /tmp/ && sudo rm -rf ./*
  sudo apt-get -y --purge autoremove

  echo "/home/cobol" >> "$GITHUB_PATH"
}

main "$@"
