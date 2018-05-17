# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Resource:: chef
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

resource_name :elite_chef
provides :elite_chef
default_action :create

property :user, String, name_property: true
property :mode, String, default: '0640'
property :cookbook, String, default: 'elite'
property :client_source, String, default: 'chef/knife.rb.erb'
property :stove_source, String, default: 'chef/stove.erb'
property :client_key_path, String, default: nil
property :node_name, String, default: 'sliim'
property :chef_server_url, String, default: nil

def whyrun_supported?
  true
end

action :create do
  user = new_resource.user

  directory "#{user_dotfiles(user)}/chef" do
    owner user
    group user_group(user)
    mode '0750'
  end

  template "#{user_dotfiles(user)}/chef/knife.rb" do
    owner user
    group user_group(user)
    mode new_resource.mode
    source new_resource.client_source
    cookbook new_resource.cookbook
    variables node_name: new_resource.node_name,
              client_key_path: new_resource.client_key_path,
              chef_server_url: new_resource.chef_server_url
  end

  template "#{user_dotfiles(user)}/stove" do
    owner user
    group user_group(user)
    mode new_resource.mode
    cookbook new_resource.cookbook
    source new_resource.stove_source
    variables node_name: new_resource.node_name,
              client_key_path: new_resource.client_key_path
  end

  %w(chef stove).each do |link|
    elite_dotlink "#{user}-#{link}" do
      owner user
      file link
    end
  end
end
