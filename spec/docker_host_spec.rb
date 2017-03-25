# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Spec:: docker_host
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

describe 'elite::docker_host' do
  let(:subject) do
    ChefSpec::SoloRunner.new(platform: 'debian',
                             version: '8.0') do |node|
      node.override['elite']['users'] = %w(sliim foo)
      node.override['elite']['groups'] = %w(elite)
      node.override['elite']['docker_host']['users'] = %w(sliim)
    end.converge(described_recipe)
  end

  it 'creates docker_service[default]' do
    expect(subject).to create_docker_service('default')
  end

  it 'starts docker_service[default]' do
    expect(subject).to start_docker_service('default')
  end

  it 'modifies group[docker]' do
    expect(subject).to modify_group('docker')
      .with(append: true,
            members: %w(sliim))
  end

  it 'creates remote_file[/usr/local/bin/ctop]' do
    expect(subject).to create_remote_file('/usr/local/bin/ctop')
      .with(source: 'https://github.com/bcicen/ctop/releases/download/v0.5.1/ctop-0.5.1-linux-amd64',
            owner: 'root',
            group: 'docker',
            mode: '0755')
  end
end
