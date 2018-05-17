# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Resource:: gtk
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

resource_name :elite_gtk
provides :elite_gtk
default_action :create

property :user, String, name_property: true
property :cookbook, String, default: 'elite'
property :source, String, default: 'gtkrc-2.0.erb'
property :font_name, String, default: 'sans 8'
property :theme_name, String, default: 'Cyanized'
property :theme_rc, String, default: 'Cyanized/gtkrc.erb'
property :icon_theme_name, String, default: 'ACYL'
property :toolbar_style, String, default: 'GTK_TOOLBAR_ICONS'
property :toolbar_icon_size, String, default: 'GTK_ICON_SIZE_SMALL_TOOLBAR'
property :color, Hash, default: { 'bg_color' => '#0C0C0E',
                                  'selected_bg_color' => '#162C30',
                                  'base_color' => '#0C0C0E',
                                  'fg_color' => '#56BFD2',
                                  'selected_fg_color' => '#00D7FF',
                                  'text_color' => '#56BFD2',
                                  'tooltip_bg_color' => '#F5F5B5',
                                  'tooltip_fg_color' => '#162C30',
                                  'link_color' => '#496B8D',
                                  'panel_bg' => '#0C0C0E',
                                }

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

  %w(gtkrc-2.0 icons themes).each do |dotf|
    elite_dotlink "#{user}-#{dotf}" do
      owner user
      file dotf
    end
  end
end
