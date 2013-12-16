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

directory '/var/www/sites' do
  owner node.easy_drupal.drupal_user
  group 'www-data'
end

drupal_config = data_bag_item('drupal', 'default').to_hash
drupal_settings "#{node.drupal.settings_dir}/default" do
  config drupal_config
  owner node.easy_drupal.drupal_user
  group 'www-data'
end
