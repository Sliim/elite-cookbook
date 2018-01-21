# -*- coding: utf-8 -*-

describe file '/home/h4x0r/.chef' do
  it { should be_directory }
  it { should be_linked_to '/home/h4x0r/.dotfiles/chef' }
  it { should be_owned_by 'h4x0r' }
  it { should be_grouped_into 'elite' }
end

describe file '/home/h4x0r/.stove' do
  it { should be_file }
  it { should be_linked_to '/home/h4x0r/.dotfiles/stove' }
  it { should be_owned_by 'h4x0r' }
  it { should be_grouped_into 'elite' }
end

describe file '/home/h4x0r/.chef/knife.rb' do
  it { should be_file }
  it { should be_mode 0640 }
  it { should be_owned_by 'h4x0r' }
  it { should be_grouped_into 'elite' }
end

describe file '/root/.chef' do
  it { should_not be_directory }
end

describe file '/root/.stove' do
  it { should_not be_file }
end
