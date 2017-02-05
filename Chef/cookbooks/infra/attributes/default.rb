default['infra']['databag_item'] = 'infra'
default['infra']['databag_name'] = 'prod'
default['infra']['env_prefix'] = 'prod'
default['infra']['app_prefix'] = 'rb'
default['infra']['network_acl_id'] = 'acl-c06442a6'
default['infra']['network_acl_name'] = "#{node['infra']['app_prefix']}_#{node['infra']['env_prefix']}_acl"


default['infra']['web_elb_sg_name'] = "#{node['infra']['app_prefix']}_#{node['infra']['env_prefix']}_web_elb_sg"
default['infra']['web_srv_sg_name'] = "#{node['infra']['app_prefix']}_#{node['infra']['env_prefix']}_web_srv_sg"
default['infra']['data_srv_sg_name'] = "#{node['infra']['app_prefix']}_#{node['infra']['env_prefix']}_data_srv_sg"

default['infra']['db_port'] = "5432"


