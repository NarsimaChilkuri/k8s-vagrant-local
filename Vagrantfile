Vagrant.configure(2) do |config|
  config.vm.define "amazonlinux" do |amazonlinux|
    amazonlinux.vm.box = "bento/amazonlinux-2"
    amazonlinux.vm.hostname = "amazonlinux"
    amazonlinux.vm.provision :shell, path: "k8s_startup.sh"
    amazonlinux.vm.network "private_network", ip: "172.42.42.100"
    amazonlinux.vm.provider "virtualbox" do |v|
      v.name = "amazonlinux"
      v.memory = 2048
      v.cpus = 3
      v.customize ["modifyvm", :id, "--audio", "none"]
    end
  end
end
