apt-get update;
yes | apt-get install git htop cmake automake libtool g++ gcc curl telnet;
yes | apt-get install libev-dev libz-dev libssl-dev pkg-config valgrind;
yes | apt-get install nginx-full mysql-server software-properties-common;
yes | apt-get install iotop ncdu virtualenv default-jdk llvm libncurses-dev;
yes | apt-get install libboost-all-dev libc6-dev-i386 libev=dev;
yes | apt-get install xvfb libgtk2.0-0 libXtst-dev libXss-dev libgconf2-dev libnss3-dev libasound-dev;

# set path
echo "" >> ~/.bashrc
echo "export NODE_PATH=/opt/node" >> ~/.bashrc;
echo "export PATH=\"\$PATH:\$NODE_PATH/bin\"" >> ~/.bashrc;
echo "export GOROOT=/opt/go" >> ~/.bashrc;
echo "export GOPATH=/root/go" >> ~/.bashrc;

# aliases
# utility aliases
echo "alias reloadbash=\". ~/.bashrc\"" >> ~/.bashrc
echo "alias rebuildebug=\"cmake -DCMAKE_BUILD_TYPE=Debug ..; make\"" >> ~/.bashrc
echo "alias rebuilrelease=\"cmake -DCMAKE_BUILD_TYPE=Release ..; make\"" >> ~/.bashrc
echo "alias nodemon7='nodemon -x \"node --harmony\"'" >> ~/.bashrc
# apt aliases
echo "alias ainstall=\"apt-get install\"" >> ~/.bashrc
echo "alias asearch=\"apt-cache search\"" >> ~/.bashrc
# git aliases
echo "alias gb=\"git branch\"" >> ~/.bashrc
echo "alias gs=\"git status\"" >> ~/.bashrc
echo "alias gc=\"git clone\"" >> ~/.bashrc
echo "alias gd=\"git diff\"" >> ~/.bashrc
echo "alias gl=\"git log\"" >> ~/.bashrc
echo "alias glo=\"git log --oneline --decorate\"" >> ~/.bashrc
echo "alias gp=\"git push\"" >> ~/.bashrc
echo "alias gcm=\"git add --all . && git commit -m \"\$1\"\"" >> ~/.bashrc
# npm aliases
echo "alias ni=\"npm i\"" >> ~/.bashrc
echo "alias nis=\"npm i --save\"" >> ~/.bashrc

source ~/.bashrc;

cd /opt;

nodever="v7.2.1"
rm -rf node-$nodever-linux-x64.tar.gz
rm -rf node
wget --no-check-certificate https://nodejs.org/dist/$nodever/node-$nodever-linux-x64.tar.gz
tar xf node-$nodever-linux-x64.tar.gz
mv node-$nodever-linux-x64 node
source ~/.bashrc;
# bu olmazsa npm i vs hata veriyor. npm <3 phen
chown -R root /opt/
npm i -g pm2 nodemon forever

# install php
yes | add-apt-repository ppa:ondrej/php;
apt-get update;
yes | apt-get install php5.6;
yes | apt-get install php5.6-fpm php5.6-mbstring php5.6-mcrypt php5.6-mysql php5.6-xml php-uuid;
yes | apt-get install php-redis php-solr php-memcached php-memcache php-libsodium php-yaml;
yes | apt-get install php-imagick php-gmagick php-gearman php-msgpack php-oauth php-uploadprogress;

# install go
cd /opt
rm -rf tar xf go1.7.linux-amd64.tar.gz
wget https://storage.googleapis.com/golang/go1.7.linux-amd64.tar.gz
tar xf go1.7.linux-amd64.tar.gz
rm -rf go1.7.linux-amd64.tar.gz

# install apache maven
cd /opt
wget http://www-eu.apache.org/dist/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz
tar xf apache-maven-3.3.9-bin.tar.gz
rm apache-maven-3.3.9-bin.tar.gz
echo "export PATH=\"\$PATH:/opt/apache-maven-3.3.9/bin\"" >> ~/.bashrc;

rm -rf c9sdk
git clone git://github.com/c9/core.git c9sdk
cd c9sdk
scripts/install-sdk.sh

cd;
rm -rf libsodium;
git clone git://github.com/jedisct1/libsodium;
cd libsodium;
./autogen.sh;
./configure --prefix=/usr;
make -j 8;
make install;

cd;
rm -rf h2o;
git clone git://github.com/h2o/h2o;
cd h2o;
cmake -DCMAKE_INSTALL_DIR=/usr .;
make -j 8;
make install;

cd;
rm -rf libhl;
git clone git://github.com/xant/libhl;
cd libhl;
autoreconf -i;
./configure --prefix=/usr;
make -j 8;
make install;

cd;
rm -rf daemonize;
git clone git://github.com/bmc/daemonize;
cd daemonize;
./configure --prefix=/usr;
make -j 8;
make install;

cd;
rm -rf nanomsg;
git clone git://github.com/nanomsg/nanomsg;
cd nanomsg
./autogen.sh
./configure --prefix=/usr
make -j 8
make install

cd;
rm -rf weighttp;
git clone git://github.com/lighttpd/weighttp;
cd weighttp;
./waf configure
./waf build
cp build/default/weighttp /usr/bin

cd;
rm -rf push.sh
echo "git add --all ." >> push.sh
echo "git commit -m \"\$1\"" >> push.sh
echo "git push -u origin master" >> push.sh
chmod +x push.sh
mv push.sh /usr/bin

# git clone github/bitbucket
echo '#!/bin/bash' >> /usr/bin/gcg
echo "git clone git@github.com:\$1" >> /usr/bin/gcg
chmod +x /usr/bin/gcg

echo '#!/bin/bash' >> /usr/bin/gcb
echo "git clone git@bitbucket.org:\$1" >> /usr/bin/gcb
chmod +x /usr/bin/gcb
