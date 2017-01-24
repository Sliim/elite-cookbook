# -*- coding: utf-8 -*-

require 'chefspec'
require 'chefspec/berkshelf'

describe 'elite::default' do
  let(:subject) do
    ChefSpec::SoloRunner.new(step_into: ['elite_user'],
                             platform: 'debian',
                             version: '8.0') do |node|
      node.override['elite']['groups'] = %w(h4x0r)
      node.override['elite']['users'] = %w(elite)
      node.override['elite']['elite'] = {
        'home' => '/home/myhome',
        'group' => 'h4x0r',
        'shell' => '/bin/bash',
        'groups' => %w(h4x0r),
        'password' => nil,
      }
    end.converge(described_recipe)
  end

  it 'creates group[elite]' do
    expect(subject).to create_group('h4x0r')
  end

  it 'creates elite_user[elite]' do
    expect(subject).to create_elite_user('elite')
  end

  it 'creates user[elite]' do
    expect(subject).to create_user('elite').with(
      home: '/home/myhome',
      shell: '/bin/bash')
  end

  it 'modifies group[h4x0r]' do
    expect(subject).to modify_group('h4x0r').with(
      members: %w(elite))
  end

  context 'without home' do
    let(:subject) do
      ChefSpec::SoloRunner.new(step_into: ['elite_user'],
                               platform: 'debian',
                               version: '8.0') do |node|
        node.override['elite']['groups'] = %w(h4x0r)
        node.override['elite']['users'] = %w(elite)
        node.override['elite']['elite'] = {
          'group' => 'h4x0r',
          'shell' => '/bin/bash',
          'groups' => %w(elite),
          'password' => nil,
        }
      end.converge(described_recipe)
    end

    it 'creates user[elite]' do
      expect(subject).to create_user('elite')
        .with(home: '/home/elite')
    end
  end

  context 'with empty shell' do
    let(:subject) do
      ChefSpec::SoloRunner.new(step_into: ['elite_user'],
                               platform: 'debian',
                               version: '8.0') do |node|
        node.override['elite']['groups'] = %w(h4x0r)
        node.override['elite']['users'] = %w(elite)
        node.override['elite']['elite'] = {
          'home' => '/home/myhome',
          'shell' => '',
          'group' => 'h4x0r',
          'groups' => %w(elite),
          'password' => nil,
        }
      end.converge(described_recipe)
    end

    it 'creates user[elite] with default user\'s shell' do
      expect(subject).to create_user('elite')
        .with(shell: '/bin/sh')
    end
  end

  context 'without shell' do
    let(:subject) do
      ChefSpec::SoloRunner.new(step_into: ['elite_user'],
                               platform: 'debian',
                               version: '8.0') do |node|
        node.override['elite']['groups'] = %w(h4x0r)
        node.override['elite']['users'] = %w(elite)
        node.override['elite']['elite'] = {
          'home' => '/home/myhome',
          'group' => 'h4x0r',
          'groups' => %w(elite),
          'password' => nil,
        }
      end.converge(described_recipe)
    end

    it 'creates user[elite] with default resource\'s default shell attribute' do
      expect(subject).to create_user('elite')
        .with(shell: '/bin/zsh')
    end
  end
end
