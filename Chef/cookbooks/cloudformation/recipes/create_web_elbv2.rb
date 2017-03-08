
include_recipe 'aws'

elbname = node['infra']['web_int_elb_name']
databag_name = node['infra']['databag_name']
databag_item_name = node['infra']['databag_item']
infra_config = data_bag_item(databag_name, databag_item_name)

web_subnet1  = infra_config['web_subnet1']
web_subnet2  = infra_config['web_subnet2']
vpc_id = infra_config['vpc_id']

target_instance1 = infra_config['web_target_instance1']
target_instance2 = infra_config['web_target_instance2']
target_instance3 = infra_config['web_target_instance3']
target_instance4 = infra_config['web_target_instance4']



web_elb_security_group_id = infra_config['web_elb_security_group_id']


aws_cloudformation_stack 'rb-prod-web-elb' do

  template_source 'create_web_elbv2.tpl'
 
  parameters ([
    {
      :parameter_key => 'ElbName',
      :parameter_value => elbname
    },
    {
      :parameter_key => 'Subnet1',
      :parameter_value => web_subnet1
    },
    {
      :parameter_key => 'Subnet2',
      :parameter_value => web_subnet2
    },
    {
      :parameter_key => 'ElbSecurityGroup',
      :parameter_value => web_elb_security_group_id
    },
    {
      :parameter_key => 'VpcId',
      :parameter_value => vpc_id
    },
    {
      :parameter_key => 'TargetInstance1',
      :parameter_value => target_instance1
    },
    {
      :parameter_key => 'TargetInstance2',
      :parameter_value => target_instance2
    },
    {
      :parameter_key => 'TargetInstance3',
      :parameter_value => target_instance3
    },
    {
      :parameter_key => 'TargetInstance4',
      :parameter_value => target_instance4
    },
  ])

end



