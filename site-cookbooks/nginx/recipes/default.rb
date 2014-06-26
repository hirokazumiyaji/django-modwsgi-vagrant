#
# Cookbook Name:: nginx
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package 'nginx' do
  action :install
end

directory '/var/log/nginx' do
  owner 'root'
  group 'root'
  mode 0755
end

directory '/etc/nginx/con


template '/etc/nginx/nginx.conf' do
  path '/etc/nginx/nginx.conf'
  source 'nginx.conf.erb'
  mode 0644
  owner 'root'
  group 'root'
end

template '/etc/nginx/conf.d/upstream.conf' do
  path '/etc/nginx/conf.d/upstream.conf'
  source 'upstream.conf.erb'
  mode 0644
  owner 'root'
  group 'root'
  variables({
    :port => 8000
  })
end

service 'nginx' do
  action [ :enable, :start ]
end
