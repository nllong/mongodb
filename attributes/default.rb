#
# Cookbook Name:: mongodb
# Attributes:: mongodb
#
# Copyright 2010, NREL
#
# All rights reserved - Do Not Redistribute
#

if platform?("redhat", "centos", "fedora")
  set[:mongodb][:server][:config_file] = "/etc/mongod.conf"
  set[:mongodb][:server][:log_file] = "/var/log/mongo/mongod.log"
  set[:mongodb][:server][:db_dir] = "/var/lib/mongo"
else
  set[:mongodb][:server][:config_file] = "/etc/mongodb.conf"
  set[:mongodb][:server][:log_file] = "/var/log/mongodb/mongodb.log"
  set[:mongodb][:server][:db_dir] = "/var/lib/mongodb"
end
