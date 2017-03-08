# infra Cookbook

Cookbook to create, modify, update environment and its entities.

e.g.
This cookbook creates app servers in environments.
This cookbook updates network acl entries in the vpc

## Requirements

This cookbook requires chef provisioning and depends on existence of a vpc with subnets, elbs and network acls.

This has been tested in Ubuntu 14.0 LTS
Works with other platforms as well.

### Chef

- Chef 12.0 or later

## Attributes

default['infra']['databag_item']     
default['infra']['databag_name'] 
default['infra']['env_prefix'] 
default['infra']['app_prefix'] 
default['infra']['network_acl_id'] 
default['infra']['network_acl_name'] 
default['infra']['pub_elb_sg_name'] 
default['infra']['pub_srv_sg_name'] 
default['infra']['web_elb_sg_name'] 
default['infra']['web_srv_sg_name'] 
default['infra']['svc_srv_sg_name'] 
default['infra']['data_srv_sg_name']
default['infra']['pub_ext_elb_name']
default['infra']['web_int_elb_name']
default['infra']['device_name']
default['infra']['pub_instance_type']
default['infra']['web_app_instance_type']
default['infra']['web_api_instance_type']
default['infra']['svc_worker_instance_type']
default['infra']['web_app_srv_name']
default['infra']['web_api_srv_name']
default['infra']['svc_worker_name'] 
default['infra']['pub_app_srv_name']
default['infra']['image_id']
default['infra']['proxy_srv_image_id'] 
default['infra']['key_name']
default['infra']['ssh_user_name']
default['infra']['instance_iam_role']
default['infra']['pub_app_srv_runlist']


## Usage

These recipes can be run from a chef provisioning machine where the chef repo is present as below.
e.g:

### infra::env_setup

    # cd chef-repo/
    # chef-client -z -r 'recipe[infra::env_setup]'


## Contributing

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github


## License and Authors

- Author:: Kamalika Majumder ([kamalika@cloudkata.com](mailto:kamalika@cloudkata.com))


Copyright 2017, Cloudkata, Staxa LLP.

```
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```

