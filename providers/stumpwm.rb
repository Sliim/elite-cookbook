# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Provider:: stumpwm
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

  template "#{user_dotfiles(user)}/stumpwmrc" do
    owner user
    group user_group(user)
    mode '0640'
    source new_resource.source
    cookbook new_resource.cookbook
    variables stumpwm: new_resource,
              username: user_name(user)
  end

  remote_directory "#{user_dotfiles(user)}/stumpwm.d" do
    owner user
    group user_group(user)
    mode '0750'
    files_owner user
    files_group user_group(user)
    files_mode '0640'
    source 'stumpwm.d'
    cookbook new_resource.cookbook
  end

  %w(stumpwmrc stumpwm.d).each do |dotf|
    elite_dotlink "#{user}-#{dotf}" do
      owner user
      file dotf
    end
  end

  %w(stumpish stumpwm).each do |bin|
    elite_bin "#{user}-#{bin}" do
      owner user
      script bin
    end
  end

  elite_picture "#{user}-#{new_resource.wallpaper}" do
    owner user
    pic new_resource.wallpaper
  end

  new_resource.updated_by_last_action(true)
end
