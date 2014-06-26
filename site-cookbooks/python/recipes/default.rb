#
# Cookbook Name:: python
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
%w{openssl-devel sqlite-devel}.each do |pkg|
  package pkg do
    action :install
  end
end

git "/home/#{node['pyenv']['user']}/.pyenv" do
  repository node['pyenv']['repo_url']
  action :sync
  user node['pyenv']['user']
  group node['pyenv']['group']
end

template ".bash_profile" do
  source ".bash_profile.erb"
  path "/home/#{node['pyenv']['user']}/.bash_profile"
  mode 0644
  owner node['pyenv']['user']
  group node['pyenv']['group']
  not_if "grep pyenv ~/.bash_profile", :environment => { :'HOME' => "/home/#{node['pyenv']['user']}" }
end

execute "pyenv install #{node['pyenv']['version']}" do
  command "/home/#{node['pyenv']['user']}/.pyenv/bin/pyenv install #{node['pyenv']['version']}"
  user node['pyenv']['user']
  group node['pyenv']['group']
  environment 'HOME' => "/home/#{node['pyenv']['user']}"
  not_if { File.exists?("/home/#{node['pyenv']['user']}/.pyenv/versions/#{node['pyenv']['version']}")}
end
