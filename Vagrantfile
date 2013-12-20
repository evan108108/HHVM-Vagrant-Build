# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
	config.vm.box = "saucy64"
	config.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/saucy/current/saucy-server-cloudimg-amd64-vagrant-disk1.box"

	config.vm.network :forwarded_port, guest: 8001, host: 8080
	config.vm.network :private_network, ip: "192.168.66.66"

	nfs = (RUBY_PLATFORM =~ /darwin/ || RUBY_PLATFORM =~ /linux/)
	config.vm.synced_folder ".", "/vagrant", :nfs => nfs

	config.vm.provider :virtualbox do |vb|
		vb.customize ["modifyvm", :id, "--memory", "1536"] # hhvm needs at least 1.2GB memory with its default config
		vb.customize ["modifyvm", :id, "--ostype", "Ubuntu_64"]
	end

	config.vm.provision "shell", inline: <<-shell
		echo "deb http://dl.hhvm.com/ubuntu saucy main" > /etc/apt/sources.list.d/hhvm.list
		apt-get update
		apt-get install hhvm -y --force-yes

		sudo chown vagrant /etc/hhvm
		sudo cp /vagrant/conf/config.hdf /etc/hhvm/config.hdf
		sudo cp /vagrant/conf/php.ini /etc/hhvm/php.ini

		echo "Creating /var/hhvm/error.log"
		sudo mkdir /var/hhvm
		sudo touch /var/hhvm/error.log
		sudo chown vagrant /var/hhvm/error.log

		hhvm -m daemon -c /etc/hhvm/config.hdf

		nohup sh /vagrant/scripts/watcher.sh > /dev/null 2>&1 &
	shell
end
