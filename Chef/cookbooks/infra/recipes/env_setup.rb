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

device_name = node['infra']['device_name']

web_app_srv_name  = node['infra']['web_app_srv_name']
web_public_app_srv_name  = node['infra']['web_public_app_srv_name']
web_smoke_srv_name  = node['infra']['web_smoke_srv_name']

svc_worker_srv_name = node['infra']['svc_worker_srv_name']
svc_dc_worker_srv_name = node['infra']['svc_dc_worker_srv_name']
svc_cron_srv_name = node['infra']['svc_cron_srv_name']
svc_testdrone_srv_name = node['infra']['svc_testdrone_srv_name']
svc_help_app_srv_name = node['infra']['svc_help_app_srv_name']
svc_help_app_worker_srv_name = node['infra']['svc_help_app_worker_srv_name']
svc_jds_app_srv_name = node['infra']['svc_jds_app_srv_name']
svc_spock_app_srv_name = node['infra']['svc_spock_app_srv_name']
svc_jds_worker_srv_name = node['infra']['svc_jds_worker_srv_name']
svc_spock_worker_srv_name = node['infra']['svc_spock_worker_srv_name']

web_int_elb_name = node['infra']['web_int_elb_name']
instance_iam_role = node['infra']['instance_iam_role']

web_srv_security_group_name = node['infra']['web_srv_sg_name']
svc_srv_security_group_name = node['infra']['svc_srv_sg_name']

web_app_srv_count = node['infra']['web_app_srv_count']
web_public_app_srv_count = node['infra']['web_public_app_srv_count']
web_smoke_srv_count = node['infra']['web_smoke_srv_count']
svc_worker_srv_count = node['infra']['svc_worker_srv_count']
svc_dc_worker_srv_count = node['infra']['svc_dc_worker_srv_count']
svc_cron_srv_count = node['infra']['svc_cron_srv_count']
svc_testdrone_srv_count = node['infra']['svc_testdrone_srv_count']
svc_help_app_srv_count = node['infra']['svc_help_app_srv_count']
svc_help_app_worker_srv_count = node['infra']['svc_help_app_worker_srv_count']
svc_jds_app_srv_count = node['infra']['svc_jds_app_srv_count']
svc_spock_app_srv_count = node['infra']['svc_spock_app_srv_count']
svc_jds_worker_srv_count = node['infra']['svc_jds_worker_srv_count']
svc_spock_worker_srv_count = node['infra']['svc_spock_worker_srv_count']

databag_name = node['infra']['databag_name']
databag_item_name = node['infra']['databag_item']
infra_config = data_bag_item(databag_name, databag_item_name)

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
       aws_tags 'machine-type' => node['infra']['appserver_machine_type'] 
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
       aws_tags 'machine-type' => node['infra']['public_appserver_machine_type']
       recipe 'bootstrap::public-appserver'
           end
       end

 1.upto(web_smoke_srv_count) do |i|
   machine "#{web_smoke_srv_name}#{i}" do
     add_machine_options bootstrap_options: {
       block_device_mappings: [{
         device_name: device_name,
         ebs: {
           volume_size: 60,
           volume_type: 'gp2',
           delete_on_termination: true,
           },
           }],
           instance_type: 't2.medium',
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
       aws_tags 'machine-type' => node['infra']['smoke_machine_type']     
       recipe 'bootstrap::smoke'      
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
            subnet_id: svc_subnet_ids[i % svc_subnet_ids.length],
            iam_instance_profile: {
              name: instance_iam_role,
              },
              monitoring: {
                enabled: true,
                },
                disable_api_termination: true,
              }
        aws_tags 'machine-type' => node['infra']['worker_machine_type']
        recipe 'bootstrap::worker'
            end
        end
 1.upto(svc_dc_worker_srv_count) do |i|
   machine "#{svc_dc_worker_srv_name}#{i}" do
     add_machine_options bootstrap_options: {
       block_device_mappings: [{
         device_name: device_name,
         ebs: {
           volume_size: 30,
           volume_type: 'gp2',
           delete_on_termination: true,
           },
           }],
           instance_type: 't2.medium',
           security_group_ids: [svc_srv_security_group_name],
           subnet_id: svc_subnet_ids[i % svc_subnet_ids.length],
           iam_instance_profile: {
             name: instance_iam_role,
             },
             monitoring: {
               enabled: true,
               },
               disable_api_termination: true,
             }
         aws_tags 'machine-type' => node['infra']['dc_worker_machine_type'] 
         recipe 'bootstrap::new-dc-worker'
       end
     end
  1.upto(svc_cron_srv_count) do |i|
    machine "#{svc_cron_srv_name}#{i}" do
      add_machine_options bootstrap_options: {
        block_device_mappings: [{
          device_name: device_name,
          ebs: {
            volume_size: 30,
            volume_type: 'gp2',
            delete_on_termination: true,
            },
            }],
            instance_type: 't2.micro',
            security_group_ids: [svc_srv_security_group_name],
            subnet_id: svc_subnet_ids[i % svc_subnet_ids.length],
            iam_instance_profile: {
              name: instance_iam_role,
              },
              monitoring: {
                enabled: true,
                },
                disable_api_termination: true,
              }
          aws_tags 'machine-type' => node['infra']['cron_machine_type']
          recipe 'bootstrap::cron'
            end
        end      
  1.upto(svc_testdrone_srv_count) do |i|
    machine "#{svc_testdrone_srv_name}#{i}" do
      add_machine_options bootstrap_options: {
        block_device_mappings: [{
          device_name: device_name,
          ebs: {
            volume_size: 30,
            volume_type: 'gp2',
            delete_on_termination: true,
            },
            }],
            instance_type: 't2.small',
            security_group_ids: [svc_srv_security_group_name],
            subnet_id: svc_subnet_ids[i % svc_subnet_ids.length],
            iam_instance_profile: {
              name: instance_iam_role,
              },
              monitoring: {
                enabled: true,
                },
                disable_api_termination: true,
              }
          aws_tags 'machine-type' => node['infra']['testdrone_machine_type']
          recipe 'bootstrap::testdrone'
            end
        end 
    1.upto(svc_help_app_srv_count) do |i|
        machine "#{svc_help_app_srv_name}#{i}" do
          add_machine_options bootstrap_options: {
            block_device_mappings: [{
              device_name: device_name,
              ebs: {
                volume_size: 30,
                volume_type: 'gp2',
                delete_on_termination: true,
                },
                }],
                instance_type: 't2.small',
                security_group_ids: [svc_srv_security_group_name],
                subnet_id: svc_subnet_ids[i % svc_subnet_ids.length],
                iam_instance_profile: {
                  name: instance_iam_role,
                  },
                  monitoring: {
                    enabled: true,
                    },
                    disable_api_termination: true,
                  }
              aws_tags 'machine-type' => node['infra']['helpapp_machine_type']
              recipe 'bootstrap::help-app'
                end
            end   

    1.upto(svc_help_app_worker_srv_count) do |i|
      machine "#{svc_help_app_worker_srv_name}#{i}" do
        add_machine_options bootstrap_options: {
          block_device_mappings: [{
            device_name: device_name,
            ebs: {
              volume_size: 30,
              volume_type: 'gp2',
              delete_on_termination: true,
              },
              }],
              instance_type: 't2.small',
              security_group_ids: [svc_srv_security_group_name],
              subnet_id: svc_subnet_ids[i % svc_subnet_ids.length],
              iam_instance_profile: {
                name: instance_iam_role,
                },
                monitoring: {
                  enabled: true,
                  },
                  disable_api_termination: true,
                }
            aws_tags 'machine-type' => node['infra']['help_app_worker_machine_type']
            recipe 'bootstrap::help-app-worker'
              end
          end 

  1.upto(svc_jds_app_srv_count) do |i|
    machine "#{svc_jds_app_srv_name}#{i}" do
      add_machine_options bootstrap_options: {
        block_device_mappings: [{
          device_name: device_name,
          ebs: {
            volume_size: 60,
            volume_type: 'gp2',
            delete_on_termination: true,
            },
            }],
            instance_type: 't2.small',
            security_group_ids: [svc_srv_security_group_name],
            subnet_id: svc_subnet_ids[i % svc_subnet_ids.length],
            iam_instance_profile: {
              name: instance_iam_role,
              },
              monitoring: {
                enabled: true,
                },
            disable_api_termination: true,
              } 
        aws_tags 'machine-type' => node['infra']['jds_app_machine_type']
        recipe 'bootstrap::jds-app'
      end
    end

  1.upto(svc_spock_app_srv_count) do |i|
    machine "#{svc_spock_app_srv_name}#{i}" do
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
            security_group_ids: [svc_srv_security_group_name],
            subnet_id: svc_subnet_ids[i % svc_subnet_ids.length],
            iam_instance_profile: {
              name: instance_iam_role,
              },
              monitoring: {
                enabled: true,
                },
            disable_api_termination: true,
              } 
        aws_tags 'machine-type' => node['infra']['spock_app_machine_type']
        recipe 'bootstrap::spock-app-server'
      end
    end
  1.upto(svc_jds_worker_srv_count) do |i|
    machine "#{svc_jds_worker_srv_name}#{i}" do
      add_machine_options bootstrap_options: {
        block_device_mappings: [{
          device_name: device_name,
          ebs: {
            volume_size: 60,
            volume_type: 'gp2',
            delete_on_termination: true,
            },
            }],
            instance_type: 't2.small',
            security_group_ids: [svc_srv_security_group_name],
            subnet_id: svc_subnet_ids[i % svc_subnet_ids.length],
            iam_instance_profile: {
              name: instance_iam_role,
              },
              monitoring: {
                enabled: true,
                },
            disable_api_termination: true,
              } 
        aws_tags 'machine-type' => node['infra']['jds_worker_machine_type']
        recipe 'bootstrap::jds-worker'
      end
    end

  1.upto(svc_spock_worker_srv_count) do |i|
    machine "#{svc_spock_worker_srv_name}#{i}" do
      add_machine_options bootstrap_options: {
        block_device_mappings: [{
          device_name: device_name,
          ebs: {
            volume_size: 60,
            volume_type: 'gp2',
            delete_on_termination: true,
            },
            }],
            instance_type: 't2.small',
            security_group_ids: [svc_srv_security_group_name],
            subnet_id: svc_subnet_ids[i % svc_subnet_ids.length],
            iam_instance_profile: {
              name: instance_iam_role,
              },
              monitoring: {
                enabled: true,
                },
            disable_api_termination: true,
              } 
        aws_tags 'machine-type' => node['infra']['spock_worker_machine_type']      
        recipe 'bootstrap::spock-worker'
      end
    end

end             



