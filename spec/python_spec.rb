# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Spec:: python
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

require_relative 'spec_helper'

describe 'elite::python' do
  let(:subject) do
    ChefSpec::SoloRunner.new(platform: 'debian',
                             version: '9.0') do |node|
      node.override['elite']['python'] = {
        '2' => {},
        '3' => {
          'options' => {
            'package_name' => 'python3',
            'dev_package' => 'python3-dev',
          },
          'packages' => ['PyYaML'],
        },
      }
    end.converge(described_recipe)
  end

  it 'installs python_runtime[2]' do
    expect(subject).to install_python_runtime('2')
  end

  it 'installs python_runtime[3]' do
    expect(subject).to install_python_runtime('3')
      .with(options: { 'package_name' => 'python3', 'dev_package' => 'python3-dev' })
  end

  it 'installs python_package[PyYaML]' do
    expect(subject).to install_python_package('PyYaML').with(python: '/usr/bin/python3')
  end
end
