# -*- coding: utf-8 -*-

['libgtk2.0-0', 'libgtk2.0-dev', 'gtk2-engines',
 'gtk2-engines-pixbuf', 'gtk2-engines-murrine'].each do |pkg|
  describe package pkg do
    it { should be_installed }
  end
end

describe file '/home/h4x0r/.gtkrc-2.0' do
  it { should be_file }
  it { should be_linked_to '/home/h4x0r/.dotfiles/gtkrc-2.0' }
  it { should be_owned_by 'h4x0r' }
  it { should be_grouped_into 'elite' }
end

describe file '/home/h4x0r/.themes' do
  it { should be_directory }
  it { should be_linked_to '/home/h4x0r/.dotfiles/themes' }
  it { should be_owned_by 'h4x0r' }
  it { should be_grouped_into 'elite' }
end

describe file '/home/h4x0r/.themes/Cyanized' do
  it { should be_directory }
  it { should be_owned_by 'h4x0r' }
end

describe file '/home/h4x0r/.icons' do
  it { should be_directory }
  it { should be_linked_to '/home/h4x0r/.dotfiles/icons' }
  it { should be_owned_by 'h4x0r' }
  it { should be_grouped_into 'elite' }
end

describe file '/home/h4x0r/.icons/ACYL' do
  it { should be_directory }
  it { should be_mode 0755 }
  it { should be_owned_by 'h4x0r' }
end
