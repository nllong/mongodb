#
# Cookbook Name:: mongodb
# Recipe:: client
#
# Copyright 2011, NREL
#
# All rights reserved - Do Not Redistribute
#

if platform?("redhat", "centos", "fedora")
  include_recipe "yum::10gen"
  package "mongo-10gen" do
  end
elsif platform?("debian")
  include_recipe "apt"
end

