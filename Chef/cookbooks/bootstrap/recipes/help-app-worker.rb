
databag_name = node['infra']['databag_name']
databag_item_name = node['infra']['bootstrap']['databag_item']
infra_config = data_bag_item(databag_name, databag_item_name)

template '/opt/bootstrap.sh' do
  source 'bootstrap.sh.erb'
  mode '750'
  variables(
    machine_hostname: node['infra']['help_app_worker_machine_hostname'],
    facter_machine_type: node['infra']['help_app_worker_machine_type'],
    facter_env_name: node['infra']['facter_env_name'],
    facter_machine_name: node['infra']['svc_help_app_worker_srv_name'],
    puppet_password: infra_config['puppet_password']

    )
  action :create
  notifies :run, 'execute[run_bootstrap]'
end

execute 'run_bootstrap' do
  command './opt/bootstrap.sh'
  subscribes :run, 'template[/opt/bootstrap.sh]'
end