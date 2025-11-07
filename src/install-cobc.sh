#!/usr/bin/env sh

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
  if [ "${input_version}" = "3.3" ]; then
    url="https://ci.appveyor.com/api/projects/GitMensch/gnucobol-3-x/artifacts/gnucobol-3.3-dev.tar.gz?job=Image:%20Ubuntu2204"
  else
    url="https://sourceforge.net/projects/open-cobol/files/gnucobol/${minor_version}/gnucobol-${input_version}.tar.gz"
  fi
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
