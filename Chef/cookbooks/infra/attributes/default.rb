default['infra']['databag_item'] = 'infra'
default['infra']['databag_name'] = 'prod'
default['infra']['bootstrap']['databag_item'] = 'bootstrap'
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

default['infra']['instance_type'] = 't2.medium'

#Server Names
default['infra']['pub_proxy_srv_name'] = "#{node['infra']['app_prefix']}_#{node['infra']['env_prefix']}_pub_http_proxy"
default['infra']['web_app_srv_name'] = "#{node['infra']['app_prefix']}_#{node['infra']['env_prefix']}_web_appserver"
default['infra']['web_public_app_srv_name'] = "#{node['infra']['app_prefix']}_#{node['infra']['env_prefix']}_web_public_appserver"

default['infra']['svc_worker_srv_name'] = "#{node['infra']['app_prefix']}_#{node['infra']['env_prefix']}_svc_worker"

default['infra']['svc_help_app_srv_name'] = "#{node['infra']['app_prefix']}_#{node['infra']['env_prefix']}_svc_help_app"
default['infra']['svc_help_app_worker_srv_name'] = "#{node['infra']['app_prefix']}_#{node['infra']['env_prefix']}_svc_help_app_worker"

default['infra']['image_id'] = 'ami-386e4350'

default['infra']['proxy_srv_image_id'] = 'ami-43271154'
default['infra']['instance_iam_role'] = 'rb_role_instance'

#RDS

default['infra']['data_subnet_group_name'] = "#{node['infra']['app_prefix']}_#{node['infra']['env_prefix']}_data_subnet_group"
default['infra']['psql_data_srv_name'] = "#{node['infra']['app_prefix']}-#{node['infra']['env_prefix']}-psql-data-srv"
default['infra']['mysql_data_srv_name'] = "#{node['infra']['app_prefix']}-#{node['infra']['env_prefix']}-mysql-data-srv"

default['infra']['psql_db_instance_type'] = "db.t2.medium"
default['infra']['mysql_db_instance_type'] = "db.t2.medium"

#Bootstrap

default['infra']['facter_env_name'] = 'production'

##appserver
default['infra']['appserver_machine_hostname'] = 'appserver'
default['infra']['appserver_machine_type'] = 'appserver'
default['infra']['appserver_machine_name'] =  ''

##public-appserver
default['infra']['public_appserver_machine_hostname'] = 'public-appserver'
default['infra']['public_appserver_machine_type'] = 'public-appserver'
default['infra']['public_appserver_machine_name'] =  ''

##worker
default['infra']['worker_machine_hostname'] = 'worker'
default['infra']['worker_machine_type'] = 'worker'
default['infra']['worker_machine_name'] =  ''

##help-app
default['infra']['helpapp_machine_hostname'] = ''
default['infra']['helpapp_machine_type'] = ''
default['infra']['helpapp_machine_name'] =  ''

##help-app-worker
default['infra']['helpapp_worker_machine_hostname'] = ''
default['infra']['helpapp_worker_machine_type'] = ''
default['infra']['helpapp_worker_machine_name'] =  ''
