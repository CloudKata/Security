
include_recipe 'aws'

elbname = node['infra']['pub_ext_elb_name']
databag_name = node['infra']['databag_name']
databag_item_name = node['infra']['databag_item']
infra_config = data_bag_item(databag_name, databag_item_name)

pub_subnet1  = infra_config['pub_subnet1']
pub_subnet2  = infra_config['pub_subnet2']
vpc_id = infra_config['vpc_id']



pub_elb_security_group_id = infra_config['pub_elb_security_group_id']


aws_cloudformation_stack 'rb-prod-pub-elb' do

  template_source 'create_pub_elbv2.tpl'
 
  parameters ([
    {
      :parameter_key => 'ElbName',
      :parameter_value => elbname
    },
    {
      :parameter_key => 'Subnet1',
      :parameter_value => pub_subnet1
    },
    {
      :parameter_key => 'Subnet2',
      :parameter_value => pub_subnet2
    },
    {
      :parameter_key => 'ElbSecurityGroup',
      :parameter_value => pub_elb_security_group_id
    },
    {
      :parameter_key => 'VpcId',
      :parameter_value => vpc_id
    },
  ])

end



