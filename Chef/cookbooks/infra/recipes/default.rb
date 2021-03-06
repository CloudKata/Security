#
# Cookbook Name:: vpc
# Recipe:: default
#
# Copyright 2017, CloudKata
#
# All rights reserved - Do Not Redistribute
#

# frozen_string_literal: true


require 'chef/provisioning/aws_driver'
with_driver 'aws::us-east-1'
iam = AWS::Core::CredentialProviders::ENVProvider.new 'AWS'

begin
  with_driver 'aws:IAM:us-east-1', aws_credentials: { 'IAM' => iam.credentials }
rescue AWS::Errors::MissingCredentialsError
  with_driver 'aws::us-east-1'
end

databag_name = node['infra']['databag_name']
infra_config = data_bag_item(databag_name, node['infra']['databag_item'])

image_id              = node['infra']['image_id']
key_name              = infra_config['key_name']
ssh_user_name         = infra_config['ssh_user_name']

with_machine_options(
  convergence_options: {
    ssl_verify_mode: :verify_none,
    install_sh_path: "~/chef-install.sh",
    chef_client_timeout: 120*120
  },
  bootstrap_options:  {
    image_id: image_id,
    key_name: key_name
  },
  ssh_username: ssh_user_name,
  transport_address_location: :private_ip

)
