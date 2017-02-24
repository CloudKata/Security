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
key_name              = node['infra']['key_name']
ssh_user_name         = node['infra']['ssh_user_name']
#client_name           = infra_config['client_name'] || Chef::Config[:node_name]
#signing_key_filename  = infra_config['signing_key_filename'] || Chef::Config[:client_key]
#ssl_verify_mode       = infra_config['ssl_verify_mode']

with_machine_options(
  convergence_options: {
    ssl_verify_mode: :verify_none,
    install_sh_path: "~/chef-install.sh"
  },
  bootstrap_options:  {
    image_id: image_id,
    key_name: key_name,
  },
  ssh_username: ssh_user_name,
  transport_address_location: :private_ip

)
