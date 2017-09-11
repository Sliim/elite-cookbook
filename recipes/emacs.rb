# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Recipe:: emacs
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

include_recipe 'elite::dotfiles'

node['elite']['users'].each do |u|
  emacs_config = user_config(u, 'emacs')
  next unless emacs_config
  elite_emacs u do
    cookbook emacs_config['cookbook'] if emacs_config['cookbook']
    repository emacs_config['repository'] if emacs_config['repository']
    reference emacs_config['reference'] if emacs_config['reference']
    apps_repository emacs_config['apps_repository'] if emacs_config['apps_repository']
    apps_reference emacs_config['apps_reference'] if emacs_config['apps_reference']
    apps_dependencies emacs_config['apps_dependencies'] if emacs_config['apps_dependencies']
    apps emacs_config['apps'] if emacs_config['apps']
    cask_install_ignore_failure emacs_config['cask_install_ignore_failure'] \
      if emacs_config['cask_install_ignore_failure']
  end
end
