elite Cookbook - [![Cookbook Version](https://img.shields.io/cookbook/v/elite.svg)](https://community.opscode.com/cookbooks/elite) [![Build Status](https://travis-ci.org/Sliim/elite-cookbook.svg?branch=master)](https://travis-ci.org/Sliim/elite-cookbook) 
================
The Elite Cookbook - Configure elite stuff

This is my personal setup, customizable with Chef.

Requirements
------------
#### Platforms
The following platforms and versions are tested and supported using Opscode's test-kitchen.
- `Debian 8`

Attributes
----------
#### elite::default
| Key                 | Type  |  Description                |
| ------------------- | ----- | --------------------------- |
| `[elite][users]`    | Array | Elite users                 |
| `[elite][groups]`   | Array | Elite groups                |
| `[elite][packages]` | Array | List of packages to install |

All others elements in the `elite` namespace is dedicated for users configuration.

Usage
-----
#### elite::default
Include the `elite` recipe in your run_list to setup elite users/groups:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[elite]"
  ],
  "attributes": {
    "elite": {
      "users": ["h4x0r"],
      "groups": ["elite"],
      "h4x0r": {
        "home": "/home/h4x0r",
        "shell": "/bin/sh",
        "groups": ["elite"]
      }
    }
  }
}
```

See `specs` or [kitchen.yml](.kitchen.yml) for more examples.

#### Recipes
- `elite::ack`
- `elite::bash`
- `elite::bin`
- `elite::cask`
- `elite::default`
- `elite::emacs`
- `elite::git`
- `elite::packages`
- `elite::pics`
- `elite::stuff`
- `elite::terminfo`
- `elite::tmux`
- `elite::x`
- `elite::zsh`

#### Custom resources
- `elite_bin`
- `elite_desktop_app`
- `elite_dotlink`
- `elite_picture`
- `elite_tmux_script`
- `elite_zsh_plugin`
- `elite_zsh_completions`
- `elite_zsh_theme`
- `elite_ack`
- `elite_bash`
- `elite_cask`
- `elite_emacs`
- `elite_git`
- `elite_pics`
- `elite_stuff`
- `elite_terminfo`
- `elite_tmux`
- `elite_user`
- `elite_x`
- `elite_zsh`

Tests
-----

- First, install dependencies:  
`bundle install`

- Run Checkstyle and ChefSpec:  
`bundle exec rake`

- Run Kitchen tests:
`bundle exec rake kitchen`

Contributing
------------
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

Licenses and Authors
-------------------
Authors: Sliim <sliim@mailoo.org> 

#### Licenses
- The elite cookbook is licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. See [LICENSE](LICENSE) file.
- Config, scripts in files/ directory are under GPLv3, see [COPYING](COPYING) file.
