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

  bin.each do |cookbook, conf|
    next unless conf.key? 'scripts'
    conf['scripts'].each do |script|
      elite_bin "#{u}-#{script}" do
        owner u
        script script
        cookbook cookbook
        source_dir conf['source_dir'] if conf['source_dir']
      end
    end
  end
end
