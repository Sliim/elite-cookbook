# -*- coding: utf-8 -*-

require 'chefspec'
require 'chefspec/berkshelf'

describe 'elite::default' do
  let(:subject) do
    ChefSpec::SoloRunner.new(step_into: ['elite_user'],
                             platform: 'debian',
                             version: '8.0') do |node|
      node.override['elite']['groups'] = %w(elite)
      node.override['elite']['users'] = %w(sliim)
      node.override['elite']['sliim'] = {
        'home' => '/home/myhome',
        'group' => 'elite',
        'shell' => '/bin/bash',
        'groups' => %w(elite),
        'password' => nil,
      }
    end.converge(described_recipe)
  end

  it 'creates group[elite]' do
    expect(subject).to create_group('elite')
  end

  it 'creates elite_user[sliim]' do
    expect(subject).to create_elite_user('sliim')
  end

  it 'creates user[sliim]' do
    expect(subject).to create_user('sliim').with(
      home: '/home/myhome',
      shell: '/bin/bash')
  end

  it 'modifies group[elite]' do
    expect(subject).to modify_group('elite').with(
      members: %w(sliim))
  end

  context 'without home' do
    let(:subject) do
      ChefSpec::SoloRunner.new(step_into: ['elite_user'],
                               platform: 'debian',
                               version: '8.0') do |node|
        node.override['elite']['groups'] = %w(elite)
        node.override['elite']['users'] = %w(sliim)
        node.override['elite']['sliim'] = {
          'group' => 'elite',
          'shell' => '/bin/bash',
          'groups' => %w(elite),
          'password' => nil,
        }
      end.converge(described_recipe)
    end

    it 'creates user[sliim]' do
      expect(subject).to create_user('sliim')
        .with(home: '/home/sliim')
    end
  end

  context 'with empty shell' do
    let(:subject) do
      ChefSpec::SoloRunner.new(step_into: ['elite_user'],
                               platform: 'debian',
                               version: '8.0') do |node|
        node.override['elite']['groups'] = %w(elite)
        node.override['elite']['users'] = %w(sliim)
        node.override['elite']['sliim'] = {
          'shell' => '',
          'group' => 'elite',
          'groups' => %w(elite),
          'password' => nil,
        }
      end.converge(described_recipe)
    end

    it 'creates user[sliim] with default user\'s shell' do
      expect(subject).to create_user('sliim')
        .with(shell: '/bin/sh')
    end
  end

  context 'without shell' do
    let(:subject) do
      ChefSpec::SoloRunner.new(step_into: ['elite_user'],
                               platform: 'debian',
                               version: '8.0') do |node|
        node.override['elite']['groups'] = %w(elite)
        node.override['elite']['users'] = %w(sliim)
        node.override['elite']['sliim'] = {
          'group' => 'elite',
          'groups' => %w(elite),
          'password' => nil,
        }
      end.converge(described_recipe)
    end

    it 'creates user[sliim] with default resource\'s default shell attribute' do
      expect(subject).to create_user('sliim')
        .with(shell: '/bin/zsh')
    end
  end
end
