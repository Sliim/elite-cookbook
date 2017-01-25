# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Provider:: dunst
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

# TODO: Improve dunst cookbook and simplify this provider

action :create do
  user = new_resource.user
  vars = new_resource.vars
  vars = node['dunst'] if vars.nil?

  elite_configd user

  ['dunst', 'alsa-utils', 'libnotify-bin'].each do |pkg|
    package pkg
  end

  directory "#{user_dotfiles(user)}/config/dunst" do
    owner user
    group user_group(user)
    mode '0750'
    recursive true
  end

  template "#{user_dotfiles(user)}/config/dunst/dunstrc" do
    owner user
    group user_group(user)
    source 'dunstrc.erb'
    cookbook 'dunst'
    mode '0640'
    variables dunst: vars
  end

  elite_bin "#{user}-notifier" do
    owner user
    script 'notifier'
  end

  %w(bip.wav alert.wav).each do |s|
    elite_sound "#{user}-#{s}" do
      owner user
      sound s
    end
  end

  new_resource.updated_by_last_action(true)
end
