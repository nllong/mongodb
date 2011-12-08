#
# Cookbook Name:: mongodb
# Attributes:: mongodb
#
# Copyright 2010, NREL
#
# All rights reserved - Do Not Redistribute
#

default[:mongodb][:client][:version] = "2.0.1-mongodb_1"
default[:mongodb][:server][:version] = "2.0.1-mongodb_1"

if platform?("redhat", "centos", "fedora")
  default[:mongodb][:server][:config_file] = "/etc/mongod.conf"
  default[:mongodb][:server][:log_file] = "/var/log/mongo/mongod.log"
  default[:mongodb][:server][:db_dir] = "/var/lib/mongo"
else
  default[:mongodb][:server][:config_file] = "/etc/mongodb.conf"
  default[:mongodb][:server][:log_file] = "/var/log/mongodb/mongodb.log"
  default[:mongodb][:server][:db_dir] = "/var/lib/mongodb"
end

default[:mongodb][:backup][:dir] = "/var/backups/mongodb"
default[:mongodb][:backup][:oplog] = true
default[:mongodb][:backup][:replica_on_slave] = true
