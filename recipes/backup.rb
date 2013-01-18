#
# Cookbook Name:: mongodb
# Recipe:: backup
#
# Copyright 2011, NREL
#
# All rights reserved - Do Not Redistribute
#

include_recipe "cron"

# Setting MAILCONTENT=quiet doesn't seem to currently work:
# https://github.com/micahwedemeyer/automongobackup/issues/17
# For now use cronic to prevent chatty output.
include_recipe "cron::cronic"

if platform?("redhat", "centos", "fedora")
  template "/etc/sysconfig/automongobackup" do
    source "automongobackup_sysconfig.erb"
    owner "root"
    group "root"
    mode "0644"
  end
end

cookbook_file "/usr/local/bin/automongobackup" do
  source "automongobackup.sh"
  owner "root"
  group "root"
  mode "0755"
end

template "/etc/cron.d/automongobackup" do
  source "cron_automongobackup.erb"
  mode "0644"
  owner "root"
  group "root"
end
