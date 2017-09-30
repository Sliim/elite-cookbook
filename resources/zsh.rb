# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Resource:: zsh
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

actions :create
default_action :create
resource_name :elite_zsh

attribute :name, kind_of: String
attribute :user, kind_of: String, name_attribute: true
attribute :cookbook, kind_of: String, default: 'elite'
attribute :source, kind_of: String, default: 'zshrc.erb'
attribute :config, kind_of: Hash, default: { 'pyenv_prompt' => false,
                                             'rbenv_prompt' => false,
                                             'ndenv_prompt' => false,
                                             'color1' => '239',
                                             'color2' => '085',
                                           }
attribute :plugins, kind_of: Hash, default: { elite: %w(common) }
attribute :completions, kind_of: Hash, default: {}
attribute :theme, kind_of: String, default: 'elite'
attribute :aliases, kind_of: Hash, default: {}
