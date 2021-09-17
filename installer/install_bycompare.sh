#http://www.scootersoftware.com/download.php?zz=kb_linux_install
wget http://www.scootersoftware.com/bcompare-4.3.7.25118_amd64.deb
sudo apt-get update
sudo apt-get install gdebi-core
sudo gdebi bcompare-4.3.7.25118_amd64.deb
#crack
#//bcompare在ubuntu的配置文件的路径是：.config/bcompare
#cd .config/bcompare/
#//在该路径下找到 registry.dat 删除即可
#rm registry.dat
