#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
%w{wget httpd-devel httpd mod_wsgi}.each do |pkg|
  package pkg do
    action :install
  end
end

template 'httpd.conf' do
  path '/etc/httpd/conf/httpd.conf'
  source 'httpd.conf.erb'
  owner 'root'
  group 'root'
  mode 0644
  notifies :reload, 'service[httpd]'
end

service 'httpd' do
  action [ :enable, :start ]
end
