#
# Cookbook Name:: mongodb
# Recipe:: backup
#
# Copyright 2011, NREL
#
# All rights reserved - Do Not Redistribute
#


if platform?("redhat", "centos", "fedora")
  template "/etc/sysconfig/automongobackup" do
    source "automongobackup_sysconfig.erb"
    owner "root"
    group "root"
    mode "0644"
  end
end

template "/usr/local/bin/automongobackup" do
  source "automongobackup.sh.erb"
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
