#
# Cookbook Name:: mongodb
# Recipe:: server
#
# Copyright 2011, NREL
#
# All rights reserved - Do Not Redistribute
#

include_recipe "yum::10gen"

package "mongo-10gen-server"

template node[:mongodb][:server][:config_path] do
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
