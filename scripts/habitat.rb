class Habitat
  def Habitat.configure(config, settings)
    # Configure The Box
    config.vm.box = "habitat"
    #config.vm.hostname = "homestead"

    config.vm.synced_folder "./", "/vagrant", disabled: true

    if settings.has_key?("do_default_map") && settings["do_default_map"] == true

      config.vm.synced_folder "scripts/", "/home/vagrant/scripts/", :create => true
      config.vm.synced_folder "habitat/", "/home/vagrant/habitat/", :create => true
      config.vm.synced_folder "habitat/web/", "/home/vagrant/web/", :create => true

    end

    # Configure A Private Network IP
    config.vm.network :private_network, ip: settings["ip"] ||= "172.22.22.22"

    # Configure A Few VirtualBox Settings
    config.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", settings["memory"] ||= "2048"]
      vb.customize ["modifyvm", :id, "--cpus", settings["cpus"] ||= "1"]
      vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    end

    # Register All Of The Configured Shared Folders
    if settings.has_key?("folders")
      settings["folders"].each do |folder|
        config.vm.synced_folder folder["map"], folder["to"], type: folder["type"] ||= nil, owner: folder["owner"] ||= nil, create: folder["create"] ||= nil
      end
    end

    # Install All The Configured Apache Sites
    # Do the defaults first
    
    if settings.has_key?("do_default_site") && settings["do_default_site"] == true

      config.vm.provision "shell" do |p|
          p.inline = "bash /home/vagrant/scripts/serve.sh $1 $2 $3 $4 $5"
          p.args = ["apache.default", "zen.local", "zen", "https://github.com/zencart/zc-v1-series.git", "v160"]
      end
    end

    if settings.has_key?("sites")
      settings["sites"].each do |site|
        config.vm.provision "shell" do |s|
            s.inline = "bash /home/vagrant/scripts/serve.sh $1 $2 $3 $4 $5"
            s.args = [site["skeleton"], site["domain"], site["dir"], site["github"] ||= "", site["branch"] ||= ""]
        end
      end
    end
  end
end
