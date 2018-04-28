# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Provider:: conky_rc
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
  user = new_resource.owner
  config = new_resource.config
  text = new_resource.text

  dbrc = begin
           data_bag_item('elite_conky', new_resource.rc)
         rescue
           nil
         end

  if dbrc
    config = dbrc['config'].merge(new_resource.config) if dbrc.key?('config')
    text = dbrc['text'] + new_resource.text if dbrc.key?('text')
  end

  template "#{user_dotfiles(user)}/conky.d/#{new_resource.rc}" do
    owner user
    group user_group(user)
    mode new_resource.mode
    source new_resource.source
    cookbook new_resource.cookbook
    variables config: config,
              text: text
  end
end
