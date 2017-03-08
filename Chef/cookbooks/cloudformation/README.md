# cloudformation Cookbook

This cookbook is used to create cloudformation stack for the below services:

1. AWS Elastic Load Balancer V2 (Application Load Balancer)
2. RDS instance
3. Subnets

## Requirements

### Chef

- Chef 12.0 or later

### Cookbooks

- `aws` - cloudformation depends on aws cookbook for the resources.
= `infra` - cloudformation depends on aws cookbook for the attributes.

## Attributes

Attributes are used from cookbook infra

## Usage

### cloudformation::create_public_elbv2

These recipes can be run from a chef provisioning machine where the chef repo is present as below.
e.g:

    # cd chef-repo/
    # chef-client -z -r 'recipe[cloudformation::create_public_elbv2]'


## Contributing

    1. Fork the repository on Github
    2. Create a named feature branch (like `add_component_x`)
    3. Write your change
    4. Write tests for your change (if applicable)
    5. Run the tests, ensuring they all pass
    6. Submit a Pull Request using Github

## License and Authors

Author:: Kamalika Majumder ([kamalika@cloudkata.com](mailto:kamalika@cloudkata.com))


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

