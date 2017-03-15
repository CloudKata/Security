default['infra']['databag_item'] = 'infra'
default['infra']['databag_name'] = 'prod'
default['infra']['bootstrap']['databag_item'] = 'bootstrap'
default['infra']['env_prefix'] = 'prod'
default['infra']['app_prefix'] = 'rb'
default['infra']['network_acl_name'] = "#{node['infra']['app_prefix']}_#{node['infra']['env_prefix']}_acl"
default['infra']['image_id'] = 'ami-386e4350'
default['infra']['proxy_srv_image_id'] = 'ami-43271154'
default['infra']['instance_iam_role'] = 'rb_role_instance'
default['infra']['device_name'] = '/dev/sda1'
default['infra']['pub_instance_type'] = 't2.medium'

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

#Server Names
##WEB
default['infra']['pub_proxy_srv_name'] = "#{node['infra']['app_prefix']}_#{node['infra']['env_prefix']}_pub_http_proxy"
default['infra']['web_app_srv_name'] = "#{node['infra']['app_prefix']}_#{node['infra']['env_prefix']}_web_appserver"
default['infra']['web_public_app_srv_name'] = "#{node['infra']['app_prefix']}_#{node['infra']['env_prefix']}_web_public_appserver"
default['infra']['web_smoke_srv_name'] = "#{node['infra']['app_prefix']}_#{node['infra']['env_prefix']}_web_smoke"

##SERVICE
default['infra']['svc_worker_srv_name'] = "#{node['infra']['app_prefix']}_#{node['infra']['env_prefix']}_svc_worker"
default['infra']['svc_dc_worker_srv_name'] = "#{node['infra']['app_prefix']}_#{node['infra']['env_prefix']}_svc_dc_worker"
default['infra']['svc_cron_srv_name'] = "#{node['infra']['app_prefix']}_#{node['infra']['env_prefix']}_svc_cron"
default['infra']['svc_testdrone_srv_name'] = "#{node['infra']['app_prefix']}_#{node['infra']['env_prefix']}_svc_testdrone"
default['infra']['svc_help_app_srv_name'] = "#{node['infra']['app_prefix']}_#{node['infra']['env_prefix']}_svc_help_app"
default['infra']['svc_help_app_worker_srv_name'] = "#{node['infra']['app_prefix']}_#{node['infra']['env_prefix']}_svc_help_app_worker"
default['infra']['svc_jds_app_srv_name'] = "#{node['infra']['app_prefix']}_#{node['infra']['env_prefix']}_svc_jds_app"
default['infra']['svc_spock_app_srv_name'] = "#{node['infra']['app_prefix']}_#{node['infra']['env_prefix']}_svc_spock_app"
default['infra']['svc_jds_worker_srv_name'] = "#{node['infra']['app_prefix']}_#{node['infra']['env_prefix']}_svc_jds_worker"
default['infra']['svc_spock_worker_srv_name'] = "#{node['infra']['app_prefix']}_#{node['infra']['env_prefix']}_svc_spock_worker"

#RDS
default['infra']['data_subnet_group_name'] = "#{node['infra']['app_prefix']}_#{node['infra']['env_prefix']}_data_subnet_group"
default['infra']['psql_data_srv_name'] = "#{node['infra']['app_prefix']}-#{node['infra']['env_prefix']}-psql-data-srv"
default['infra']['mysql_data_srv_name'] = "#{node['infra']['app_prefix']}-#{node['infra']['env_prefix']}-mysql-data-srv"

default['infra']['psql_db_instance_type'] = "db.t2.medium"
default['infra']['mysql_db_instance_type'] = "db.t2.medium"

#Machine Count

default['infra']['pub_srv_count'] = 2
default['infra']['web_app_srv_count'] = 2
default['infra']['web_public_app_srv_count'] = 2
default['infra']['web_smoke_srv_count'] = 1
default['infra']['svc_worker_srv_count'] = 2
default['infra']['svc_dc_worker_srv_count'] = 2
default['infra']['svc_cron_srv_count'] = 1
default['infra']['svc_testdrone_srv_count'] = 1
default['infra']['svc_help_app_srv_count'] = 1
default['infra']['svc_help_app_worker_srv_count'] = 1
default['infra']['svc_jds_app_srv_count'] = 1
default['infra']['svc_spock_app_srv_count'] = 1
default['infra']['svc_jds_worker_srv_count'] = 1
default['infra']['svc_spock_worker_srv_count'] = 1


#Bootstrap

default['infra']['facter_env_name'] = 'production'

##appserver
default['infra']['appserver_machine_hostname'] = 'appserver'
default['infra']['appserver_machine_type'] = 'appserver'

##smoke
default['infra']['smoke_machine_hostname'] = 'smoke'
default['infra']['smoke_machine_type'] = 'smoke'

##public-appserver
default['infra']['public_appserver_machine_hostname'] = 'public-app'
default['infra']['public_appserver_machine_type'] = 'public-app'

##worker
default['infra']['worker_machine_hostname'] = 'worker'
default['infra']['worker_machine_type'] = 'worker'

##new-dc-worker
default['infra']['dc_worker_machine_hostname'] = 'new-dc-worker'
default['infra']['dc_worker_machine_type'] = 'new-dc-worker'

##cron
default['infra']['cron_machine_hostname'] = 'cron'
default['infra']['cron_machine_type'] = 'cron'

##cron
default['infra']['testdrone_machine_hostname'] = 'testdrone'
default['infra']['testdrone_machine_type'] = 'testdrone'


##help-app
default['infra']['helpapp_machine_hostname'] = 'help-app'
default['infra']['helpapp_machine_type'] = 'help-app'

##help-app-worker
default['infra']['help_app_worker_machine_hostname'] = 'help-app-worker'
default['infra']['help_app_worker_machine_type'] = 'help-app-worker'

##jds-app
default['infra']['jds_app_machine_hostname'] = 'jds-app'
default['infra']['jds_app_machine_type'] = 'jds-app'

##spock-app
default['infra']['spock_app_machine_hostname'] = 'spock-app-server'
default['infra']['spock_app_machine_type'] = 'spock-app-server'

##jds-worker
default['infra']['jds_worker_machine_hostname'] = 'jds-worker'
default['infra']['jds_worker_machine_type'] = 'jds-worker'

##spock-worker
default['infra']['spock_worker_machine_hostname'] = 'spock-worker'
default['infra']['spock_worker_machine_type'] = 'spock-worker'

