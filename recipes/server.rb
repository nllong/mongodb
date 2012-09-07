#
# Cookbook Name:: mongodb
# Recipe:: server
#
# Copyright 2011, NREL
#
# All rights reserved - Do Not Redistribute
#

include_recipe "iptables::mongodb"
include_recipe "yum::10gen"
include_recipe "mongodb::client"

package "mongo-10gen-server" do
  notifies :restart, "service[mongodb]"
end

directory node[:mongodb][:server][:db_dir] do
  owner "mongod"
  group "mongod"
  mode "0755"
  recursive true
end

template node[:mongodb][:server][:config_file] do
  source "mongodb.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  notifies :restart, "service[mongodb]"
end

if platform?("redhat", "centos", "fedora")
  template "/etc/sysconfig/mongod" do
    source "sysconfig.erb"
    owner "root"
    group "root"
    mode "0644"
    notifies :restart, "service[mongodb]"
  end
end

service "mongodb" do
  if platform?("redhat", "centos", "fedora")
    service_name "mongod"
  end

  supports :status => true, :restart => true
  action [:enable, :start]
end
