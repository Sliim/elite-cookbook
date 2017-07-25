# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Recipe:: python
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

node['elite']['python'].each do |version, config|
  python_runtime version do
    options config['options'] if config.key? 'options'
  end
  next unless config.key? 'packages'
  config['packages'].each do |package|
    python_package package do
      python version
    end
  end
end
