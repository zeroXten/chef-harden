#
# Cookbook Name:: harden
# Recipe:: default
#
# Copyright (C) 2014 
#
# 
#
include_recipe 'sensu_spec::definitions'
include_recipe 'harden::definitions'

node.harden.recipes.keys.each do |r|
  include_recipe "harden::#{r}" if node.harden.recipes[r]
end

include_recipe 'sensu_spec::client'
