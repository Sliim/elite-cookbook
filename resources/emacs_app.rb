# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Resource:: emacs_app
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

resource_name :elite_emacs_app
provides :elite_emacs_app
default_action :create

property :owner, String
property :app, String
property :config, Hash, default: {}

def whyrun_supported?
  true
end

action :create do
  user = new_resource.owner
  app = new_resource.app
  config = new_resource.config

  desktop = config['desktop'] || {}

  elite_desktop_app "#{user}-#{app}" do
    not_if { desktop.nil? }
    owner user
    app app
    config desktop
  end

  case app
  when 'elfeed'
    feeds = config['feeds']
    template "#{user_dotfiles(user)}/elfeed.el" do
      not_if { feeds.nil? }
      owner user
      group user_group(user)
      mode '0640'
      source 'emacs-apps/elfeed.el.erb'
      variables feeds: feeds
    end

    elite_dotlink "#{user}-elfeed.el" do
      owner user
      file 'elfeed.el'
    end
  when 'jabber'
    accounts = config['accounts']
    template "#{user_dotfiles(user)}/jabber.el" do
      not_if { accounts.nil? }
      owner user
      group user_group(user)
      mode '0640'
      source 'emacs-apps/jabber.el.erb'
      variables accounts: accounts
    end

    elite_dotlink "#{user}-jabber.el" do
      owner user
      file 'jabber.el'
    end
  end
end
