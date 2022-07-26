#!/bin/bash
sudo apt-get update
sudo apt-get -y install curl tar libncurses5-dev libgmp-dev libdb-dev
sudo apt-get -y autoremove
sudo apt-get -y install iproute2

# download and install open-cobol for depencies (libcob >= 4.0)
sudo apt-get -y install ranger autoconf build-essential
curl -sLk https://sourceforge.net/projects/open-cobol/files/gnu-cobol/"${1}"/gnucobol-"${2}".tar.gz | tar xz
cd gnucobol-"${2}" && ./configure --prefix=/usr && sudo make && sudo make install && sudo ldconfig && cd /tmp/ && rm -rf ./*
sudo apt-get -y --purge autoremove

sudo chmod +x /home/cobol/cobol-unit-test/run-ut
sudo chmod +x /home/cobol/cobol-unit-test/compile
sudo chmod +x /home/cobol/cobol-unit-test/upload/ZUTZCPC

# shellcheck disable=SC2086
echo "/home/cobol" >> $GITHUB_PATH
