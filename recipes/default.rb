#
# Cookbook Name:: easy_drupal
# Recipe:: default
#
# Copyright (C) 2013 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'build-essential'
include_recipe 'drupal::mass_virtual'
include_recipe 'apache2::mod_php5'
include_recipe 'postfix'

settings_path = "#{node.drupal.settings_dir}/default"
app_path      = "#{node.drupal.apps_dir}/default"
drupal_config = data_bag_item('drupal', 'default').to_hash

[settings_path, app_path].each do |dir|
  directory dir do
    owner node.drupal.user
    group node.drupal.group
  end
end

drupal_settings settings_path do
  config drupal_config
  owner node.drupal.user
  group node.drupal.group
end

file ::File.join(app_path, 'env.json') do
  owner node.drupal.user
  group node.drupal.group
  content ::JSON.pretty_generate(conf_dir: settings_path)
  mode    00640
end
