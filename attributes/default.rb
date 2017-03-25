# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Attributes:: default
#

default['elite']['groups'] = []
default['elite']['users'] = []

default['elite']['packages'] = []
default['elite']['locales'] = []

default['elite']['slim']['theme'] = 'default'
default['elite']['slim']['user'] = 'elite'
default['elite']['slim']['session'] = 'stumpwm'
default['elite']['slim']['additional_themes'] = {}

default['elite']['docker_host']['users'] = []
default['elite']['docker_host']['ctop_url'] = 'https://github.com/bcicen/ctop/releases/download/v0.5.1/ctop-0.5.1-linux-amd64'
