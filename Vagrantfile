VAGRANTFILE_API_VERSION = "2"

path = "#{File.dirname(__FILE__)}"

require 'fileutils'

if ! File.exists?(path + '/Habitat.yaml')
  begin
    FileUtils.copy(path + '/Habitat.yaml.example', path + '/Habitat.yaml')
  rescue
    print "Could not copy Habitat.yaml.example to Habitat.yaml\n"
  end
end

if ! File.exists?(path + '/Habitat.yaml')
  print "You need to manually copy Habitat.yaml.example to Habitat.yaml\n"
  exit 1
end

require 'yaml'
require path + '/habitat.rb'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |vconfig|
  vconfig.vm.define :Habitat do |config|
    Habitat.configure(config, YAML::load(File.read(path + '/Habitat.yaml')))
  end
end
