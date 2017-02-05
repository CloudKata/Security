#
# Cookbook Name:: vpc
# Recipe:: network_acl
#
# Copyright 2017, CloudKata
#
# All rights reserved - Do Not Redistribute
#


require 'chef/provisioning/aws_driver'
with_driver 'aws::us-east-1'

databag_name = node['infra']['databag_name']
databag_item_name = node['infra']['databag_item']
infra_config = data_bag_item(databag_name, databag_item_name)

acl_name = node['infra']['network_acl_name']
acl_id = infra_config['network_acl_id']

aws_network_acl acl_name do
	network_acl_id acl_id
	inbound_rules (
		[
			{ rule_number: 1, action: :allow, protocol: 6, port_range: 80..80, cidr_block: '0.0.0.0/0' },
			{ rule_number: 2, action: :allow, protocol: 6, port_range: 443..443, cidr_block: '0.0.0.0/0' },
			{ rule_number: 3, action: :allow, protocol: 6, port_range: 943..943, cidr_block: '0.0.0.0/0' },
			{ rule_number: 4, action: :allow, protocol: 6, port_range: 1194..1194, cidr_block: '0.0.0.0/0' },
			{ rule_number: 5, action: :allow, protocol: 6, port_range: 1024..65535, cidr_block: '0.0.0.0/0' },
			{ rule_number: 100, action: :deny, protocol: -1, cidr_block: '0.0.0.0/0' },
		]
		)
	aws_tags :Name => acl_name
end