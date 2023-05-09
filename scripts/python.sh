version="3.8.3"
echo "Install Python v${version} from python.org"
cd /source/
wget https://www.python.org/ftp/python/${version}/Python-${version}.tgz
tar -xf Python-${version}.tgz
cd /source/python-${version}
./configure --enable-optimizations
rm /source/python-${version} -rf
rm /source/Python-${version}.tgz
apt-get -y install python3-pip
pip install mysql-connector-python