# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "centos6.5"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  config.vm.network "forwarded_port", guest: 80, host: 8000

  # config.vm.synced_folder "../data", "/vagrant_data"
  config.vm.provision :shell , :inline => "if [ ! -f /usr/bin/chef-solo ]; then curl -L https://www.opscode.com/chef/install.sh | sudo bash; fi"

  config.vm.provision "chef_solo" do |chef|
    chef.cookbooks_path = "site-cookbooks"
    chef.add_recipe "git"
    #chef.add_recipe "python"
    chef.add_recipe "nginx"
    chef.add_recipe "apache"
    chef.add_recipe "mysql"
    chef.add_recipe "redis"

    chef.json = { mysql_password: "" }
  end

end
