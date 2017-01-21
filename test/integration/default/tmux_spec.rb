# -*- coding: utf-8 -*-

describe package('tmux') do
  it { should be_installed }
end

describe file('/home/h4x0r/.tmux.conf') do
  it { should be_file }
  it { should be_linked_to '/home/h4x0r/.dotfiles/tmux.conf' }
  it { should be_owned_by 'h4x0r' }
  it { should be_grouped_into 'elite' }
end

describe file '/root/.tmux.conf' do
  it { should_not be_file }
end

describe file('/tmp/tmux-test') do
  it { should be_file }
  it { should be_executable }
  it { should be_owned_by 'h4x0r' }
  it { should be_grouped_into 'elite' }
end
