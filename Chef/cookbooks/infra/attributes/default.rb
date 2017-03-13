default['infra']['databag_item'] = 'infra'
default['infra']['databag_name'] = 'prod'
default['infra']['env_prefix'] = 'prod'
default['infra']['app_prefix'] = 'rb'
default['infra']['network_acl_name'] = "#{node['infra']['app_prefix']}_#{node['infra']['env_prefix']}_acl"

#Security Group Names:

default['infra']['pub_elb_sg_name'] = "#{node['infra']['app_prefix']}_#{node['infra']['env_prefix']}_pub_elb_sg"
default['infra']['pub_srv_sg_name'] = "#{node['infra']['app_prefix']}_#{node['infra']['env_prefix']}_pub_srv_sg"
default['infra']['web_elb_sg_name'] = "#{node['infra']['app_prefix']}_#{node['infra']['env_prefix']}_web_elb_sg"
default['infra']['web_srv_sg_name'] = "#{node['infra']['app_prefix']}_#{node['infra']['env_prefix']}_web_srv_sg"
default['infra']['svc_srv_sg_name'] = "#{node['infra']['app_prefix']}_#{node['infra']['env_prefix']}_svc_srv_sg"
default['infra']['data_srv_sg_name'] = "#{node['infra']['app_prefix']}_#{node['infra']['env_prefix']}_data_srv_sg"

#Load Balancer Names:
default['infra']['pub_ext_elb_name'] = "#{node['infra']['app_prefix']}-#{node['infra']['env_prefix']}-pub-ext-elb"
default['infra']['web_int_elb_name'] = "#{node['infra']['app_prefix']}-#{node['infra']['env_prefix']}-web-int-elb"

default['infra']['device_name'] = '/dev/sda1'

default['infra']['pub_instance_type'] = 't2.medium'
default['infra']['web_app_instance_type'] = 't2.medium'
default['infra']['web_api_instance_type'] = 't2.medium'
default['infra']['svc_worker_instance_type'] = 't2.medium'

#Server Names
default['infra']['web_app_srv_name'] = "#{node['infra']['app_prefix']}_#{node['infra']['env_prefix']}_web_app_srv"
default['infra']['web_api_srv_name'] = "#{node['infra']['app_prefix']}_#{node['infra']['env_prefix']}_web_public_app_srv"
default['infra']['svc_worker_name'] = "#{node['infra']['app_prefix']}_#{node['infra']['env_prefix']}_svc_worker_srv"
default['infra']['pub_app_srv_name'] = "#{node['infra']['app_prefix']}_#{node['infra']['env_prefix']}_http_proxy_srv"

default['infra']['image_id'] = 'ami-386e4350'

default['infra']['proxy_srv_image_id'] = 'ami-43271154'
default['infra']['key_name'] = 'ssh-default'
default['infra']['ssh_user_name'] = 'ec2-user'

default['infra']['instance_iam_role'] = 'rb_role_instance'
default['infra']['pub_app_srv_runlist'] = "recipe['nginx_proxy']"

#RDS

default['infra']['data_subnet_group_name'] = "#{node['infra']['app_prefix']}_#{node['infra']['env_prefix']}_data_subnet_group"
default['infra']['psql_data_srv_name'] = "#{node['infra']['app_prefix']}-#{node['infra']['env_prefix']}-psql-data-srv"
default['infra']['mysql_data_srv_name'] = "#{node['infra']['app_prefix']}-#{node['infra']['env_prefix']}-mysql-data-srv"

default['infra']['psql_db_instance_type'] = "db.t2.medium"
default['infra']['mysql_db_instance_type'] = "db.t2.medium"

