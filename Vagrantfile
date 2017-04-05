Vagrant.configure("2") do |config|
	
	# Operating system
	config.vm.box = "ubuntu/xenial64"

	# Networking
	config.vm.network "private_network", ip: "192.168.3.3"

    # File sharing
    config.vm.synced_folder "./htdocs", "/var/www/html", type: "nfs"

    # Configuration
    config.vm.provider "virtualbox" do |v|
    	v.name = "Dev"
    	v.customize ["modifyvm", :id, "--memory", "4096"]
    end

    # Provisioning
    config.vm.provision "shell" do |s|
    	s.path = "provision/setup.sh"
    end

end
