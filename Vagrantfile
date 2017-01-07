# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure(2) do |config|
  config.vm.box = "bento/centos-6.8"

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "512"]
  end

  config.vm.define "server" do |conf|
    conf.vm.network "private_network", ip: "192.168.100.50"
    conf.vm.provision "ansible_local" do |ansible|
      ansible.playbook = "./server.yml"
      #ansible.verbose  = "v"
    end
  end

  [1, 2].each do |idx|
    config.vm.define "client#{idx}" do |conf|
      conf.vm.network "private_network", ip: "192.168.100.5#{idx}"
      conf.vm.provision "ansible_local" do |ansible|
        ansible.playbook = "./client.yml"
        #ansible.verbose  = "v"
      end
    end
  end
end
