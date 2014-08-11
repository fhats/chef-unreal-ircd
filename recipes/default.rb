#
# Cookbook Name:: unreal-ircd
# Recipe:: default
#
# Copyright (C) 2014 Fred Hatfull
#
# 
#

user node['unreal']['user'] do
  comment "Unreal IRCd user"
  only_if { node['unreal']['create_user'] }
  shell "/bin/false"
  system true
end

directory ::File.dirname(node['unreal']['pidfile']) do
  owner    node['unreal']['user']
end

directory ::File.dirname(node['unreal']['tunefile']) do
  owner    node['unreal']['user']
end

include_recipe "unreal-ircd::source"

template "#{node['unreal']['unreal_directory']}/unrealircd.conf" do
  source "unrealircd.conf.erb"
  owner  node['unreal']['user']
  mode   "0644"
end

directory "#{node['unreal']['unreal_directory']}/unrealircd.conf.d" do
  owner node['unreal']['user']
  recursive true
end

