# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Spec:: conky_dzen2
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

describe 'elite::conky_dzen2' do
  let(:subject) do
    ChefSpec::SoloRunner.new(step_into: %w(elite_conky_dzen2),
                             platform: 'debian',
                             version: '9.0') do |node|
      node.override['elite']['users'] = %w(sliim foo)
      node.override['elite']['groups'] = %w(elite)
      node.override['elite']['sliim']['home'] = '/home/sliim'
      node.override['elite']['sliim']['group'] = 'elite'
      node.override['elite']['sliim']['groups'] = %w(elite)
      node.override['elite']['sliim']['dotfd'] = '/home/sliim/.dotfiles'
      node.override['elite']['sliim']['conky']['panel']['default_color'] = 'AAAAAA'
      node.override['elite']['sliim']['conky']['panel']['color1'] = 'BBBBBB'
      node.override['elite']['sliim']['conky']['panel']['color2'] = 'CCCCCC'
      node.override['elite']['sliim']['conky']['panel']['color3'] = 'DDDDDD'
      node.override['elite']['sliim']['conky']['panel']['color4'] = 'EEEEEE'
      node.override['elite']['sliim']['conky']['panel']['cpu_count'] = 42
      node.override['elite']['sliim']['conky']['panel']['battery'] = 'BAT1337'
      node.override['elite']['sliim']['conky']['panel']['ethernet_interface'] = 'eth0'
      node.override['elite']['sliim']['conky']['panel']['wireless_interface'] = 'wlan0'
    end.converge(described_recipe)
  end

  it 'includes recipe[elite::dotfiles]' do
    expect(subject).to include_recipe('elite::dotfiles')
  end

  it 'includes recipe[elite::conky]' do
    expect(subject).to include_recipe('elite::conky')
  end

  it 'includes recipe[elite::dzen2]' do
    expect(subject).to include_recipe('elite::dzen2')
  end

  it 'creates elite_conky_dzen2[sliim]' do
    expect(subject).to create_elite_conky_dzen2('sliim')
  end

  it 'does not create elite_conky_dzen2[foo]' do
    expect(subject).to_not create_elite_conky_dzen2('foo')
  end

  it 'creates template[/home/sliim/.dotfiles/conky.d/dzen2]' do
    expect(subject).to create_template('/home/sliim/.dotfiles/conky.d/dzen2')
      .with(owner: 'sliim',
            group: 'elite',
            mode: '0640',
            source: 'conky.d/dzen2.erb',
            cookbook: 'elite')
  end

  it 'creates cookbook_file[/home/sliim/.dotfiles/conky.d/scripts/battery-notify.sh]' do
    expect(subject).to create_cookbook_file('/home/sliim/.dotfiles/conky.d/scripts/battery-notify.sh')
      .with(owner: 'sliim',
            group: 'elite',
            mode: '0750',
            source: 'conky.d/scripts/battery-notify.sh',
            cookbook: 'elite')
  end
end
