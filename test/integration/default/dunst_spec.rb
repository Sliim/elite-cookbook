# -*- coding: utf-8 -*-

describe file '/home/h4x0r/bin/notifier' do
  it { should be_file }
  it { should be_executable }
  it { should be_owned_by 'h4x0r' }
  it { should be_grouped_into 'elite' }
end

describe file '/home/h4x0r/.sounds' do
  it { should be_directory }
  it { should be_linked_to '/home/h4x0r/.dotfiles/sounds' }
  it { should be_owned_by 'h4x0r' }
  it { should be_grouped_into 'elite' }
end

describe file '/home/h4x0r/.sounds/alert.wav' do
  it { should be_file }
  it { should be_mode 0640 }
  it { should be_owned_by 'h4x0r' }
  it { should be_grouped_into 'elite' }
end

describe file '/home/h4x0r/.sounds/bip.wav' do
  it { should be_file }
  it { should be_mode 0640 }
  it { should be_owned_by 'h4x0r' }
  it { should be_grouped_into 'elite' }
end
