require 'chef/provisioning/aws_driver'
aws_network_acl 'test1' do
	vpc 'test1-vpc'
	network_acl_id 'acl-d86439be'
	inbound_rules (
		[
			{ rule_number: 100, action: :deny, protocol: -1, cidr_block: '0.0.0.0/0' },
			{ rule_number: 1, action: :allow, protocol: 6, port_range: 80..80, cidr_block: '0.0.0.0/0' },
			{ rule_number: 2, action: :allow, protocol: 6, port_range: 443..80, cidr_block: '0.0.0.0/0' },
			{ rule_number: 3, action: :allow, protocol: 6, port_range: 943..943, cidr_block: '0.0.0.0/0' },
			{ rule_number: 4, action: :allow, protocol: 6, port_range: 1194..1194, cidr_block: '0.0.0.0/0' },
		]
		)
	aws_tags :Name => 'test1'
end