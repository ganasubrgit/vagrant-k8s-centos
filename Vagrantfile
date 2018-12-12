Vagrant.configure('2') do |config|

  # Enabling  X-Forwarding
  config.ssh.forward_x11 = true
  config.ssh.forward_agent = true

  # Config files
  config.vm.box = 'centos/7'
  config.vm.provision "file", source: "config/hosts", destination: "config/hosts"
  config.vm.provision "file", source: "config/k8s.conf", destination: "config/k8s.conf"
  config.vm.provision "file", source: "config/resolv.conf", destination: "config/resolv.conf"
  config.vm.provision "file", source: "config/kubernetes.repo", destination: "config/kubernetes.repo"

  # Scripts
  config.vm.provision "file", source: "scripts/files.sh", destination: "scripts/files.sh"
  config.vm.provision "file", source: "scripts/common.sh", destination: "scripts/common.sh"
  config.vm.provision "file", source: "scripts/docker.sh", destination: "scripts/docker.sh"
  config.vm.provision "file", source: "scripts/kubernetes.sh", destination: "scripts/kubernetes.sh"
  config.vm.provision "file", source: "scripts/kubernetes-master.sh", destination: "scripts/kubernetes-master.sh"
  config.vm.provision "file", source: "scripts/kubernetes-minion.sh", destination: "scripts/kubernetes-minion.sh"

  # Add host network manager
  # config.vm.network "private_network", type: "dhcp", ip: "192.168.121.1"
  config.vm.provider "virtualbox" do |vb|
    vb.cpus = 2
    vb.memory = 2048
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  end

  # Run scripts for all VMs
  config.vm.provision :shell, path: 'scripts/files.sh'
  # config.vm.provision :shell, path: 'scripts/common.sh'
  # config.vm.provision :shell, path: 'scripts/kernel.sh'
  config.vm.provision :shell, path: 'scripts/docker.sh'
  config.vm.provision :shell, path: 'scripts/kubernetes.sh'

  config.vm.define 'master' do |master|
    master.vm.hostname = 'master'
    master.vm.network "private_network", ip: '192.168.121.110'
    master.vm.provision :shell, path: 'scripts/kubernetes-master.sh'
  end

  config.vm.define 'node01' do |minion|
    minion.vm.provider "virtualbox" do |vm|
      vm.cpus = 1
      vm.memory = 1024
    end
    minion.vm.hostname = 'node01'
    minion.vm.network "private_network", ip: '192.168.121.111'
    minion.vm.provision :shell, path: 'scripts/kubernetes-minion.sh'
  end

  config.vm.define 'node02' do |minion|
    minion.vm.provider "virtualbox" do |vm|
      vm.cpus = 1
      vm.memory = 1024
    end
    minion.vm.hostname = 'node02'
    minion.vm.network "private_network", ip: '192.168.121.112'
    minion.vm.provision :shell, path: 'scripts/kubernetes-minion.sh'
  end

  # config.vm.define 'node03' do |minion|
  #   minion.vm.provider "virtualbox" do |vm|
  #     vm.cpus = 1
  #     vm.memory = 1024
  #   end
  #   minion.vm.hostname = 'node03'
  #   minion.vm.network "private_network", ip: '192.168.121.113'
  #   minion.vm.provision :shell, path: 'scripts/kubernetes-minion.sh'
  # end

end
