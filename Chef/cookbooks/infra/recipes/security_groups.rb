#
# Cookbook Name:: vpc
# Recipe:: security_groups
#
# Copyright 2017, CloudKata
#
# All rights reserved - Do Not Redistribute
#

# frozen_string_literal: true

require 'chef/provisioning/aws_driver'
with_driver 'aws::us-east-1'


web_elb_security_group_name = node['infra']['web_elb_sg_name']
web_srv_security_group_name = node['infra']['web_srv_sg_name']
data_srv_security_group_name = node['infra']['data_srv_sg_name']
db_port = node['infra']['db_port']

databag_name = node['infra']['databag_name']
databag_item_name = node['infra']['databag_item']
infra_config = data_bag_item(databag_name, databag_item_name)

vpc_id = infra_config['vpc_id']
openvpn_sg = infra_config['openvpn_sg']
chefmgmt_sg = infra_config['chefmgmt_sg']
public_elb = infra_config['public_elb']

def get_inbound_rules(ports, sources)
  rules = []
  ports.each_with_index do |port_num, index|
    rule = { port: port_num, protocol: :tcp, sources: sources }
    rules.insert(index, rule)
  end
  rules
end

security_groups = []

security_groups.push(sg_name: web_elb_security_group_name,
                     sg_rules: [
                       { port: 80, protocol: :tcp, sources: [{ load_balancer: 'public_elb' }] },
                     ],)

security_groups.push(sg_name: web_srv_security_group_name,
                     sg_rules: [
                       { port: 80, protocol: :tcp, sources: [web_elb_security_group_name] },
                       { port: 22, protocol: :tcp, sources: [openvpn_sg, chefmgmt_sg] },
                     ],)

db_sources = [web_srv_security_group_name, openvpn_sg, chefmgmt_sg]

security_groups.push(sg_name: data_srv_security_group_name,
                     sg_rules: [
                       { port: db_port, protocol: :tcp, sources: db_sources }
                     ],)

security_groups.each do |sg|
  aws_security_group sg[:sg_name] do
    vpc vpc_id
    aws_tags aws_tags
    inbound_rules sg[:sg_rules]
  end
end




