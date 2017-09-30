# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Provider:: zsh
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
  plugins = []
  completions = []

  directory "#{user_dotfiles(user)}/zsh.d" do
    owner user
    group user_group(user)
    mode '0750'
  end

  cookbook_file "#{user_dotfiles(user)}/zsh.d/init.zsh" do
    owner user
    group user_group(user)
    mode '0640'
    source 'zsh.d/init.zsh'
  end

  remote_directory "#{user_dotfiles(user)}/zsh.d/lib" do
    owner user
    group user_group(user)
    mode '0750'
    files_owner user
    files_group user_group(user)
    files_mode '0640'
    source 'zsh.d/lib'
  end

  new_resource.plugins.each do |cb, plugs|
    plugs.each do |p|
      elite_zsh_plugin "#{user}-#{p}" do
        owner user
        plugin p
        cookbook cb.to_s
      end
      plugins << p
    end
  end

  new_resource.completions.each do |cb, comps|
    comps.each do |c|
      elite_zsh_completion "#{user}-#{c}" do
        owner user
        completion c
        cookbook cb.to_s
      end
      completions << c
    end
  end

  elite_zsh_theme "#{user}-#{new_resource.theme}" do
    owner user
    theme new_resource.theme
    cookbook new_resource.cookbook
  end

  template "#{user_dotfiles(user)}/zshrc" do
    owner user
    group user_group(user)
    mode '0640'
    cookbook new_resource.cookbook
    source new_resource.source
    variables config: new_resource.config,
              plugins: plugins,
              completions: completions,
              theme: new_resource.theme,
              aliases: new_resource.aliases
  end

  %w(zshrc zsh.d).each do |l|
    elite_dotlink "#{user}-#{l}" do
      owner user
      file l
    end
  end
end
