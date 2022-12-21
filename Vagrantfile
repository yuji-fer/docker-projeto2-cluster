machines = {
  "master" => {"ip" => "192.168.56.2"},
  "node01" => {"ip" => "192.168.56.3"},
  "node02" => {"ip" => "192.168.56.4"}
}

filename = "worker.sh"

Vagrant.configure("2") do |config|

  machines.each do |name, conf|
    config.vm.define "#{name}" do |machine|
      machine.vm.box = "bento/ubuntu-22.04"
      machine.vm.hostname = "#{name}"
      machine.vm.network "private_network", ip: "#{conf["ip"]}"
      machine.vm.provider "virtualbox" do |vb|
        vb.name = "#{name}"
        vb.memory = 1024
        vb.cpus = 1
        
      end
      machine.vm.provision "shell", path: "docker.sh"

      if "#{name}" == "master"
        machine.vm.provision "shell", inline: <<-SHELL
          cd /vagrant
          echo '#!/bin/bash' > #{filename}
          echo -e 'echo "Configurando worker node..."\n' >> #{filename}

          echo 'Incluindo host como master node...'
          docker swarm init --advertise-addr #{conf["ip"]} | grep -i 'docker swarm join --token' - | awk '{$1=$1};1' >> #{filename}
        SHELL

        machine.vm.provision "start-service", type: "shell", run: "never", path: "start-service.sh"
      else
        machine.vm.provision "shell", path: "#{filename}"
      end

    end
  end

end