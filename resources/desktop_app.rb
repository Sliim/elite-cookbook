# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Resource:: desktop_app
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

resource_name :elite_desktop_app
provides :elite_desktop_app
default_action :create

property :app, String, name_property: true
property :owner, String
property :cookbook, String, default: 'elite'
property :source_dir, String, default: 'applications/'
property :config, Hash, default: nil

def whyrun_supported?
  true
end

action :create do
  if node.recipe?('elite::x')
    user = new_resource.owner
    location = "#{user_dotfiles(user)}/local/share/applications"

    directory location do
      owner user
      group user_group(user)
      mode '0750'
      recursive true
      notifies :run, 'execute[chown-local-user-dir]', :delayed
    end

    execute 'chown-local-user-dir' do
      command "chown -R #{user}:#{user_group(user)} #{user_dotfiles(user)}/local"
      action :nothing
    end

    elite_dotlink "#{user}-local" do
      skip_if_exists true
      owner user
      file 'local'
    end

    if new_resource.config
      template "#{location}/#{new_resource.app}.desktop" do
        owner user
        group user_group(user)
        mode '0640'
        cookbook new_resource.cookbook
        source 'app.desktop.erb'
        variables app: new_resource.config
      end
    else
      cookbook_file "#{location}/#{new_resource.app}.desktop" do
        owner user
        group user_group(user)
        mode '0640'
        cookbook new_resource.cookbook
        source "#{new_resource.source_dir}#{new_resource.app}.desktop"
      end
    end
  else
    Chef::Log.warn('Node doesn\'t includes elite::x recipe. Skip desktop application')
  end
end
