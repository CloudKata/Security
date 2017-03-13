#
# Cookbook Name:: vpc
# Recipe:: env_setup
#
# Copyright 2017, CloudKata
#
# All rights reserved - Do Not Redistribute
#

# frozen_string_literal: true
include_recipe 'infra::default'
#include_recipe 'infra::network_acl'
#include_recipe 'infra::security_groups'


device_name = node['infra']['device_name']

web_app_srv_name  = node['infra']['web_app_srv_name']
web_public_app_srv_name  = node['infra']['web_public_app_srv_name']
svc_worker_srv_name = node['infra']['svc_worker_srv_name']

web_int_elb_name     = node['infra']['web_int_elb_name']
instance_iam_role = node['infra']['instance_iam_role']

web_srv_security_group_name = node['infra']['web_srv_sg_name']
svc_srv_security_group_name = node['infra']['svc_srv_sg_name']

databag_name = node['infra']['databag_name']
databag_item_name = node['infra']['databag_item']
infra_config = data_bag_item(databag_name, databag_item_name)

web_app_srv_count = infra_config['web_app_srv_count']
web_public_app_srv_count = infra_config['web_public_app_srv_count']
svc_worker_srv_count = infra_config['svc_worker_srv_count']

web_subnet_ids  = infra_config['web_subnet_ids']
svc_subnet_ids  = infra_config['svc_subnet_ids']
chef_environment = infra_config['chef_environment']


machine_batch do
  1.upto(web_app_srv_count) do |i|
    machine "#{web_app_srv_name}#{i}" do
      add_machine_options bootstrap_options: {
        block_device_mappings: [{
          device_name: device_name,
          ebs: {
            volume_size: 60,
            volume_type: 'gp2',
            delete_on_termination: true,
            },
            }],
            instance_type: 'm4.xlarge',
            security_group_ids: [web_srv_security_group_name],
            subnet_id: web_subnet_ids[i % web_subnet_ids.length],
            iam_instance_profile: {
              name: instance_iam_role,
              },
              monitoring: {
                enabled: true,
                },
            disable_api_termination: true,
              } 
        recipe 'bootstrap::appserver'      
            end
          end
1.upto(web_public_app_srv_count) do |i|
  machine "#{web_public_app_srv_name}#{i}" do
    add_machine_options bootstrap_options: {
      block_device_mappings: [{
        device_name: device_name,
        ebs: {
          volume_size: 60,
          volume_type: 'gp2',
          delete_on_termination: true,
          },
          }],
          instance_type: 't2.large',
          security_group_ids: [web_srv_security_group_name],
          subnet_id: web_subnet_ids[i % web_subnet_ids.length],
          iam_instance_profile: {
            name: instance_iam_role,
            },
            monitoring: {
              enabled: true,
              },
              disable_api_termination: true,
            }
      recipe 'bootstrap::public-appserver'
          end
      end

1.upto(svc_worker_srv_count) do |i|
  machine "#{svc_worker_srv_name}#{i}" do
    add_machine_options bootstrap_options: {
      block_device_mappings: [{
        device_name: device_name,
        ebs: {
          volume_size: 30,
          volume_type: 'gp2',
          delete_on_termination: true,
          },
          }],
          instance_type: 'r3.2xlarge',
          security_group_ids: [svc_srv_security_group_name],
          subnet_id: svc_subnet_ids[i % svc_subnet_ids  .length],
          iam_instance_profile: {
            name: instance_iam_role,
            },
            monitoring: {
              enabled: true,
              },
              disable_api_termination: true,
            }
      recipe 'bootstrap::worker'
          end
      end
    end


              



