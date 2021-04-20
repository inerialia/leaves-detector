$script = <<-SCRIPT
apt-get update
apt-get install git docker docker-compose -y
apt-get install landscape-common -y
wget --quiet --no-check-certificate -O Dynatrace-OneAgent-Linux-latest.sh "https://syb31902.sprint.dynatracelabs.com/api/v1/deployment/installer/agent/unix/default/latest?Api-Token=APITOKEN&arch=x86&flavor=default"
/bin/sh Dynatrace-OneAgent-Linux-latest.sh --set-host-group=vagrant
systemctl enable docker && systemctl start docker
usermod -aG docker vagrant
git clone https://github.com/apmlabs/leaves-detector
chown -R vagrant:vagrant leaves-detector
cd leaves-detector/api.service/
sh docker-build.sh
cd ../model.service/
sh docker-build.sh
cd ../ui.service/prediction-ui
sudo apt-get -y install curl dirmngr apt-transport-https lsb-release 
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get install -y nodejs
npm install -y -g @angular/cli
npm install -y
npm audit fix
ng build --prod
cd ../
sh docker-build.sh
cd ../
docker-compose up
SCRIPT

$script_everystartup = <<-SCRIPT
SCRIPT

Vagrant.configure("2") do |config|
  config.vm.provider "virtualbox" do |v|
    v.memory = 8192
    v.cpus = 4
  end

  config.vm.box = "ubuntu/bionic64"
  config.vm.hostname = "leaves-detector"
  config.vm.provision "shell", inline: $script
  config.vm.provision "shell", inline: $script_everystartup, run: 'always'
  config.vm.network "private_network", ip: "192.168.12.34"
end


