elite Cookbook
================
The Elite Cookbook - Configure elite stuff

[![Cookbook Version](https://img.shields.io/cookbook/v/elite.svg)](https://community.opscode.com/cookbooks/elite) [![Build Status](https://travis-ci.org/sliim-cookbooks/elite.svg?branch=master)](https://travis-ci.org/sliim-cookbooks/elite) 

Requirements
------------
#### Platforms
The following platforms and versions are tested and supported using Opscode's test-kitchen.
- `Debian 8`

Attributes
----------
#### elite::default
| Key               | Type  |  Description |
| ----------------- | ----- | ------------ |
| `[elite][users]`  | Array | Elite users  |
| `[elite][groups]` | Array | Elite groups |

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

License and Authors
-------------------
Authors: Sliim <sliim@mailoo.org> 

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
