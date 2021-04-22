rm -rf leaves-detector/
git clone https://github.com/inerialia/leaves-detector
chown -R vagrant:vagrant leaves-detector
cd leaves-detector/api.service/
sh docker-build.sh
cd ../model.service/
sh docker-build.sh
cd ../ui.service/prediction-ui
sudo apt-get -y install curl dirmngr apt-transport-https lsb-release 
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get install -y nodejs
npm install -y -g @angular/cli > /dev/null
npm install -y > /dev/null
npm audit fix
ng build --prod
cd ../
sh docker-build.sh
cd ../
docker-compose up
