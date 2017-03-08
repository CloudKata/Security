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

Authors: Kamalika Majumder (kamalika@cloudkata.com)
Apache License version 2.0

