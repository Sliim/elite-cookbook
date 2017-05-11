# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Recipe:: bin
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
  bin = user_config(u, 'bin')
  next unless bin

  directory "#{user_dotfiles(u)}/bin" do
    owner u
    group user_group(u)
    mode '0750'
  end

  elite_dotlink "#{u}-bin" do
    dotprefix false
    owner u
    file 'bin'
  end

  next unless bin.key?('scripts')

  bin['scripts'].each do |b|
    elite_bin "#{u}-#{b}" do
      owner u
      script b
      cookbook bin['cookbook'] if bin['cookbook']
      source bin['source_dir'] if bin['source_dir']
    end
  end
end
