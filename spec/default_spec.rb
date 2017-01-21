# -*- coding: utf-8 -*-

require 'chefspec'
require 'chefspec/berkshelf'

describe 'elite::default' do
  let(:subject) do
    ChefSpec::SoloRunner.new(step_into: ['elite_user'],
                             platform: 'debian',
                             version: '8.0') do |node|
      node.override['elite']['groups'] = %w(elite)
      node.override['elite']['users'] = %w(elite)
      node.override['elite']['elite'] = {
        'home' => '/home/elite',
        'dotfd' => '/home/elite/.stuff',
        'group' => 'elite',
        'shell' => '/bin/bash',
        'groups' => %w(elite),
        'password' => nil
      }
    end.converge(described_recipe)
  end

  it 'creates group[elite]' do
    expect(subject).to create_group('elite')
  end

  it 'creates elite_user[elite]' do
    expect(subject).to create_elite_user('elite')
  end

  it 'creates user[elite]' do
    expect(subject).to create_user('elite').with(
      home: '/home/elite',
      shell: '/bin/bash')
  end

  it 'modifies group[elite]' do
    expect(subject).to modify_group('elite').with(
      members: %w(elite))
  end
end
