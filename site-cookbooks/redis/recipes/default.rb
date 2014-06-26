#
# Cookbook Name:: redis
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#
directory '/etc/redis' do
  owner 'root'
  group 'root'
  mode 0755
end

directory '/var/log/redis' do
  owner 'root'
  group 'root'
  mode 0755
end

directory '/var/lib/redis' do
  owner 'root'
  group 'root'
  mode 0755
end

remote_file "/tmp/redis-#{node['redis']['version']}.tar.gz" do
  source "http://download.redis.io/releases/redis-#{node['redis']['version']}.tar.gz"
  not_if "ls /usr/local/bin/redis-server"
end

bash 'redis install' do
  cwd "/tmp"
  code <<-EOF
    tar xzvf /tmp/redis-"#{node['redis']['version']}".tar.gz
    (cd /tmp/redis-"#{node['redis']['version']}" && make && make install)
  EOF
  not_if "test -d /usr/local/bin/redis-server"
end

template 'redis' do
  path '/etc/init.d/redis'
  source 'redis.erb'
  owner 'root'
  group 'root'
  mode 0755
end

template 'redis.conf' do
  path '/etc/redis.conf'
  source 'redis.conf.erb'
  owner 'root'
  mode 0644

  variables({
    :port => 6379
  })
  notifies :reload, 'service[redis]'
end

service 'redis' do
  action [ :enable, :start ]
end
