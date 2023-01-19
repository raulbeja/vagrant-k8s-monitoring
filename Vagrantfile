

nodes = [
    { :hostname => 'K8master',
      :ip => '192.168.56.20',
      :box => 'bento/ubuntu-20.04',
      :ram => 2048,
      :cpus => 2 }, 
    { :hostname => 'K8worker1',
      :ip => '192.168.56.51',
      :box => 'bento/ubuntu-20.04',
      :ram => 1024,
      :cpus => 1 }
  ]

Vagrant.configure("2") do |config|
    if Vagrant.has_plugin?("vagrant-vbguest")
        config.vbguest.auto_update = false
    end
    config.hostmanager.enabled = true
    config.hostmanager.manage_guest = true
    config.vm.provision "shell", path: "./vm-script/bootstrap.sh"
    nodes.each do |node|        
        config.vm.define node[:hostname] do |nodeconfig|
            nodeconfig.vm.box = node[:box]
            nodeconfig.vm.hostname = node[:hostname]
            nodeconfig.vm.network "private_network", ip: node[:ip]
            nodeconfig.vm.provider :virtualbox do |vb|
                vb.memory = node[:ram] ? node[:ram] : 512;
                vb.cpus = node[:cpus] ? node[:cpus] : 1;
            end
            if node[:hostname]=="K8master"
                nodeconfig.vm.provision "shell", path: "./vm-script/master.sh"
            else
                nodeconfig.vm.provision "shell", path: "./vm-script/worker.sh"
            end
        end
    end
end
