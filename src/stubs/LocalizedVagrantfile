require 'json'
require 'yaml'

VAGRANTFILE_API_VERSION = "2"
confDir = $confDir ||= File.expand_path("~/.rubick")

rubickYamlPath = confDir + "/Rubick.yaml"
rubickJsonPath = confDir + "/Rubick.json"
afterScriptPath = confDir + "/after.sh"
aliasesPath = confDir + "/aliases"

require File.expand_path(File.dirname(__FILE__) + '/scripts/rubick.rb')

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    if File.exists? aliasesPath then
        config.vm.provision "file", source: aliasesPath, destination: "~/.bash_aliases"
    end

    if File.exists? rubickYamlPath then
        Rubick.configure(config, YAML::load(File.read(rubickYamlPath)))
    elsif File.exists? rubickJsonPath then
        Rubick.configure(config, JSON.parse(File.read(rubickJsonPath)))
    end

    if File.exists? afterScriptPath then
        config.vm.provision "shell", path: afterScriptPath
    end
end