#!/bin/bash
apt-get update
apt-get -y upgrade
apt-get -y install curl tar libncurses5-dev libgmp-dev libdb-dev
apt-get -y autoremove
apt-get -y install iproute2

# download and install open-cobol for depencies (libcob >= 4.0)
apt-get -y install ranger autoconf build-essential
curl -sLk https://sourceforge.net/projects/open-cobol/files/gnu-cobol/3.0/gnucobol-${1}.tar.gz | tar xz
cd gnucobol-${1} && ./configure --prefix=/usr && make && make install && ldconfig && cd /tmp/ && rm -rf *
apt-get -y --purge autoremove

chmod +x /home/cobol/cobol-unit-test/run-ut
chmod +x /home/cobol/cobol-unit-test/compile
chmod +x /home/cobol/cobol-unit-test/upload/ZUTZCPC

echo "::add-path::/home/cobol"