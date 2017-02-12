# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Provider:: gtk
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

use_inline_resources

def whyrun_supported?
  true
end

action :create do
  user = new_resource.user

  template "#{user_dotfiles(user)}/gtkrc-2.0" do
    owner user
    group user_group(user)
    mode '0640'
    source new_resource.source
    cookbook new_resource.cookbook
    variables gtk: new_resource
  end

  directory "#{user_dotfiles(user)}/themes" do
    owner user
    group user_group(user)
    mode '0750'
  end

  remote_directory "#{user_dotfiles(user)}/themes/#{new_resource.theme_name}" do
    owner user
    group user_group(user)
    mode '0750'
    files_owner user
    files_group user_group(user)
    files_mode '0640'
    source "gtk/themes/#{new_resource.theme_name}"
    cookbook new_resource.cookbook
  end

  template "#{user_dotfiles(user)}/themes/#{new_resource.theme_name}/gtk-2.0/gtkrc" do
    owner user
    group user_group(user)
    mode '0640'
    source "gtk/themes/#{new_resource.theme_rc}"
    cookbook new_resource.cookbook
    variables gtk: new_resource
    only_if { %w(Cyanized Redified Greenified Orangified).include? new_resource.theme_name }
  end

  directory "#{user_dotfiles(user)}/icons" do
    owner user
    group user_group(user)
    mode '0750'
  end

  cookbook_file "#{Chef::Config[:file_cache_path]}/icons.tar.gz" do
    source "gtk/icons/#{new_resource.icon_theme_name}.tar.gz"
    cookbook new_resource.cookbook
  end

  execute "tar --keep-newer-files -xzf #{Chef::Config[:file_cache_path]}/icons.tar.gz" do
    cwd "#{user_dotfiles(user)}/icons"
    user user
    group user_group(user)
  end

  %w(gtkrc-2.0 icons themes).each do |dotf|
    elite_dotlink "#{user}-#{dotf}" do
      owner user
      file dotf
    end
  end

  new_resource.updated_by_last_action(true)
end
