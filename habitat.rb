class Habitat
  def Habitat.configure(config, settings)
    # Configure the box

    config.vm.box = "zencart/habitat"
    config.vm.box_url = "https://s3.amazonaws.com/zencart-vagrant-boxes/habitat.box"
    #config.vm.box_version = "~1.0"
    #config.vm.box_check_update = false

    config.vm.hostname = "habitat.dev"

    config.vm.synced_folder "./", "/vagrant", disabled: true

    if !settings.has_key?("do_default_map") || settings["do_default_map"] != false

      config.vm.synced_folder "scripts/", "/home/vagrant/scripts/", :create => true
      config.vm.synced_folder "habitat/", "/home/vagrant/habitat/", :create => true
      config.vm.synced_folder "habitat/web/", "/home/vagrant/web/", :create => true

    end

    # Configure A Private Network IP
    config.vm.network :private_network, ip: settings["ip"] ||= "172.22.22.22"
    config.vm.network "forwarded_port", guest: 3306, host: 3306

    # Configure A Few VirtualBox Settings
    config.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", settings["memory"] ||= "2048"]
      vb.customize ["modifyvm", :id, "--cpus", settings["cpus"] ||= "1"]
      vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    end

    # Configure The Public Key For SSH Access
    if settings.has_key?("authorize")
      config.vm.provision "shell" do |s|
        s.inline = "echo $1 | tee -a /home/vagrant/.ssh/authorized_keys"
        s.args = [File.read(settings["authorize"])]
      end
    end

    # Copy The SSH Private Keys To The Box
    if settings.has_key?("keys")
      settings["keys"].each do |key|
        config.vm.provision "shell" do |s|
          s.privileged = false
          s.inline = "echo \"$1\" > /home/vagrant/.ssh/$2 && chmod 600 /home/vagrant/.ssh/$2"
          s.args = [File.read(key), key.split('/').last]
        end
      end
    end

    # Register All Of The Configured Shared Folders
    if settings.has_key?("folders")
      settings["folders"].each do |folder|
        config.vm.synced_folder folder["map"], folder["to"], type: folder["type"] ||= nil, owner: folder["owner"] ||= nil, create: folder["create"] ||= nil
      end
    end

    # Install All The Configured Apache Sites

    if settings.has_key?("sites")
      settings["sites"].each do |site|
        config.vm.provision "shell" do |s|
            s.inline = "bash /home/vagrant/scripts/serve.sh $1 $2 $3 $4 $5"
            s.args = [site["skeleton"], site["domain"], site["dir"], site["github"] ||= "", site["branch"] ||= ""]
        end
      end
    end

    # Install localized unit-testing tools
    if !settings.has_key?("localize_tools") || settings["localize_tools"] == true
      config.vm.provision "shell" do |s|
        s.inline = "bash /home/vagrant/scripts/tools.sh"
      end
    end

  end
end
