#!/usr/bin/env bash

# install nextflow
wget -qO- https://get.nextflow.io | bash
sudo mv nextflow /usr/bin
sudo chmod 777 /usr/bin/nextflow

# install Python3.9
sudo yum install gcc openssl-devel bzip2-devel libffi-devel
cd /opt 
wget https://www.python.org/ftp/python/3.9.16/Python-3.9.16.tgz 
sudo tar xzf Python-3.9.16.tgz
cd Python-3.9.16 
sudo ./configure --enable-optimizations 
sudo make install 

# make sure python requirements exist
cd /home/ec2-user
wget http://hgdownload.soe.ucsc.edu/admin/exe/linux.x86_64/lastz-1.04.00 -O lastz
sudo mkdir /home/ec2-user/bin
sudo mv /home/ec2-user/lastz /home/ec2-user/bin/
sudo chmod +x /home/ec2-user/bin/lastz
git clone https://github.com/hillerlab/make_lastz_chains.git
cd make_lastz_chains
pip3 install -r requirements.txt
./install_dependencies.py
export PATH="$HOME/make_lastz_chains/HL_kent_binaries/:$PATH"
export PATH="$HOME/make_lastz_chains/:$PATH"
sudo chmod -R 777 "/home/ec2-user/make_lastz_chains"

# clone the repository
cd /home/ec2-user
git clone https://github.com/hillerlab/TOGA.git
cd TOGA
# install necessary python packages:
python3 -m pip install -r requirements.txt
# call configure to:
# 1) train xgboost models
# 2) download CESAR2.0
# 3) compile C code
./configure.sh
sudo chmod -R 777 "/home/ec2-user/TOGA"
# run a test, it will take a couple of minutes
#./run_test.sh micro
