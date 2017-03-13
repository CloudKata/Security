
include_recipe 'infra::default'

device_name = node['infra']['device_name']
pub_instance_type = node['infra']['pub_instance_type']
pub_proxy_srv_name  = node['infra']['pub_proxy_srv_name']
pub_ext_elb_name  = node['infra']['pub_ext_elb_name']
instance_iam_role = node['infra']['instance_iam_role']
pub_srv_security_group_name = node['infra']['pub_srv_sg_name']
pub_app_srv_runlist = node['infra']['pub_app_srv_runlist']

databag_name = node['infra']['databag_name']
databag_item_name = node['infra']['databag_item']
infra_config = data_bag_item(databag_name, databag_item_name)

pub_srv_count = infra_config['pub_srv_count']
pub_subnet_ids  = infra_config['pub_subnet_ids']

machine_batch do
  1.upto(pub_srv_count) do |i|
    machine "#{pub_proxy_srv_name}#{i}" do
      add_machine_options bootstrap_options: {
        block_device_mappings: [{
          device_name: device_name,
          ebs: {
            volume_size: 60,
            volume_type: 'gp2',
            delete_on_termination: true,
            },
            }],
            instance_type: pub_instance_type,
            security_group_ids: [pub_srv_security_group_name],
            subnet_id: pub_subnet_ids[i % pub_subnet_ids.length],
            associate_public_ip_address: true,
            iam_instance_profile: {
              name: instance_iam_role,
              },
              monitoring: {
                enabled: true,
                },
            disable_api_termination: false,
            user_data: "#{pub_proxy_srv_name}#{i}"
          }
            end
          end
        end