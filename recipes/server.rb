#
# Cookbook Name:: mongodb
# Recipe:: server
#
# Copyright 2011, NREL
#
# All rights reserved - Do Not Redistribute
#


if platform?("redhat", "centos", "fedora")
  include_recipe "iptables::mongodb"
  include_recipe "logrotate"
  include_recipe "yum::10gen"

  include_recipe "mongodb::client"
elsif platform?("ubuntu")
  include_recipe "apt"

  #install the key and mongo repo via mongo instructions
  bash "10gen_repo" do
    #install the non x86 version
    cwd Chef::Config[:file_cache_path]

    code <<-EOH
      apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
      echo "deb http://downloads-distro.mongodb.org/repo/debian-sysvinit dist 10gen" > /etc/apt/sources.list.d/10gen.list
    EOH

    not_if { ::File.exists?("/etc/apt/sources.list.d/10gen.list") }

    notifies :run, resources(:execute => "apt-get update"), :immediately
  end
end

if platform?("redhat", "centos", "fedora")
  package "mongo-10gen-server" do
    notifies :restart, "service[mongodb]"
  end
elsif platform?("ubuntu")
  package "mongodb-10gen" do
    notifies :restart, "service[mongodb]"
  end
end

if platform?("redhat", "centos", "fedora")
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

if platform?("redhat", "centos", "fedora")
  logrotate_app "mongodb" do
    path ["/var/log/mongo/mongod.log"]
    frequency "daily"
    rotate 90
    create "640 mongod mongod"
  end
end