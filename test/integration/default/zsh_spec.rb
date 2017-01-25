# -*- coding: utf-8 -*-

describe package 'zsh' do
  it { should be_installed }
end

describe file '/home/h4x0r/.zshrc' do
  it { should be_file }
  it { should be_linked_to '/home/h4x0r/.dotfiles/zshrc' }
  it { should be_owned_by 'h4x0r' }
  it { should be_grouped_into 'elite' }
end

describe file '/root/.zshrc' do
  it { should_not be_file }
end

describe file '/home/h4x0r/.zsh.d' do
  it { should be_directory }
  it { should be_linked_to '/home/h4x0r/.dotfiles/zsh.d' }
  it { should be_owned_by 'h4x0r' }
  it { should be_grouped_into 'elite' }
end

describe file '/root/.zsh.d' do
  it { should_not be_file }
end

describe user 'h4x0r' do
  its(:shell) { should eq '/bin/zsh' }
end
