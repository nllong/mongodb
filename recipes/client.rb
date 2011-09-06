#
# Cookbook Name:: mongodb
# Recipe:: client
#
# Copyright 2011, NREL
#
# All rights reserved - Do Not Redistribute
#

include_recipe "yum::10gen"

package "mongo-10gen" do
  version node[:mongodb][:client][:version]
end
