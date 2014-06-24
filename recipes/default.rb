#
# Cookbook Name:: harden
# Recipe:: default
#
# Copyright (C) 2014 
#
# 
#
include_recipe 'sensu_spec::client'

node.harden.recipes.keys.each do |r|
  include_recipe "harden::#{r}" if node.harden.recipes[r]
end
