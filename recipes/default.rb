#
# Cookbook Name:: harden
# Recipe:: default
#
# Copyright (C) 2014 
#
# 
#

include_recipe 'sensu_spec::base'
include_recipe 'harden::definitions'

include_recipe 'harden::security_updates'

include_recipe 'sensu_spec::client'
