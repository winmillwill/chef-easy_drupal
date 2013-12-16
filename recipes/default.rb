#
# Cookbook Name:: easy_drupal
# Recipe:: default
#
# Copyright (C) 2013 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

node.override.build_essential.compiletime = true
include_recipe 'build-essential'
include_recipe 'drupal'
include_recipe 'apache2'
include_recipe 'apache2::mod_php5'
include_recipe 'postfix'

drupal_config = data_bag_item('drupal', 'default').to_hash
drupal_settings "#{node.drupal.settings_dir}/default" do
  config drupal_config
  owner 'vagrant'
  group 'www-data'
end
