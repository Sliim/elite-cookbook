# -*- coding: utf-8 -*-

describe file '/home/h4x0r/.terminfo' do
  it { should be_directory }
  it { should be_linked_to '/home/h4x0r/.dotfiles/terminfo' }
  it { should be_owned_by 'h4x0r' }
  it { should be_grouped_into 'elite' }
end

describe file '/root/.terminfo' do
  it { should_not be_file }
end
