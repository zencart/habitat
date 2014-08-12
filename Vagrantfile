VAGRANTFILE_API_VERSION = "2"

path = "#{File.dirname(__FILE__)}"

require 'fileutils'

if ! File.exists?(path + '/Habitat.local.yaml')
  begin
    FileUtils.copy(path + '/Habitat.yaml.example', path + '/Habitat.local.yaml')
  rescue
    print "Could not copy Habitat.yaml.example to Habitat.local.yaml\n"
  end
end

if ! File.exists?(path + '/Habitat.local.yaml')
  print "You need to manually copy Habitat.yaml.example to Habitat.local.yaml\n"
  exit 1
end

require 'yaml'
require path + '/habitat.rb'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |vconfig|
  vconfig.vm.define :Habitat do |config|
    Habitat.configure(config, YAML::load(File.read(path + '/Habitat.local.yaml')))
  end
end
