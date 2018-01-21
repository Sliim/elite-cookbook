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
  pics = user_config(user, 'pics')
  modules = []

  elite_picture "#{user}-#{new_resource.wallpaper}" do
    owner user
    pic new_resource.wallpaper
    cookbook pics['cookbook'] if pics['cookbook']
    source_dir pics['source_dir'] if pics['source_dir']
    only_if { pics }
  end

  elite_stumpwm_d user

  git "#{user_dotfiles(user)}/stumpwm.d/modules/contrib" do
    user user
    group user_group(user)
    repository 'https://github.com/stumpwm/stumpwm-contrib'
    reference 'master'
    action :sync
    only_if { new_resource.contrib }
  end

  new_resource.modules.each do |cookbook, mods|
    mods.each do |mod|
      elite_stumpwm_module "#{user}-#{mod}" do
        owner user
        mod mod
        cookbook cookbook.to_s
        not_if { cookbook == 'contrib' }
      end
      modules << mod
    end
  end

  template "#{user_dotfiles(user)}/stumpwmrc" do
    owner user
    group user_group(user)
    mode '0640'
    source new_resource.source
    cookbook new_resource.cookbook
    variables stumpwm: new_resource,
              username: user_name(user),
              commands: new_resource.commands,
              programs: new_resource.programs,
              sessions: new_resource.sessions,
              init_cmds: new_resource.init_cmds,
              kbd: new_resource.kbd,
              modules: modules,
              webjumps: new_resource.webjumps,
              config: new_resource.config
  end

  elite_dotlink "#{user}-stumpwm.d" do
    owner user
    file 'stumpwm.d'
  end

  elite_dotlink "#{user}-stumpwmrc" do
    owner user
    file 'stumpwmrc'
  end

  elite_bin "#{user}-stumpish" do
    owner user
    script 'stumpish'
  end
end
