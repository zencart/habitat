VAGRANTFILE_API_VERSION = "2"

path = "#{File.dirname(__FILE__)}"

require 'yaml'
require path + '/scripts/habitat.rb'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  Habitat.configure(config, YAML::load(File.read(path + '/Habitat.yaml')))
end
