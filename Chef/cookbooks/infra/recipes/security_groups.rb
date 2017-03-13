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

pub_elb_security_group_name = node['infra']['pub_elb_sg_name']
pub_srv_security_group_name = node['infra']['pub_srv_sg_name']
web_elb_security_group_name = node['infra']['web_elb_sg_name']
web_srv_security_group_name = node['infra']['web_srv_sg_name']
svc_srv_security_group_name = node['infra']['svc_srv_sg_name']
data_srv_security_group_name = node['infra']['data_srv_sg_name']


databag_name = node['infra']['databag_name']
databag_item_name = node['infra']['databag_item']
infra_config = data_bag_item(databag_name, databag_item_name)

vpc_id = infra_config['vpc_id']
openvpn_sg = infra_config['openvpn_sg']
chefmgmt_sg = infra_config['chefmgmt_sg']


security_groups = []

security_groups.push(sg_name: pub_elb_security_group_name,
                     sg_rules: [
                       { port: 80, protocol: :tcp, sources: ['0.0.0.0/0'] },
                       { port: 443, protocol: :tcp, sources: ['0.0.0.0/0'] }

                     ],)

security_groups.push(sg_name: pub_srv_security_group_name,
                     sg_rules: [
                       { port: 80, protocol: :tcp, sources: [pub_elb_security_group_name] },
                       { port: 443, protocol: :tcp, sources: [pub_elb_security_group_name] },
                       { port: 22, protocol: :tcp, sources: [openvpn_sg, chefmgmt_sg] }

                     ],)

security_groups.push(sg_name: web_elb_security_group_name,
                     sg_rules: [
                       { port: 80, protocol: :tcp, sources: [pub_srv_security_group_name] },
                       { port: 80, protocol: :tcp, sources: [pub_elb_security_group_name] },
                     ],)

security_groups.push(sg_name: web_srv_security_group_name,
                     sg_rules: [
                       { port: 80, protocol: :tcp, sources: [web_elb_security_group_name] },
                       { port: 22, protocol: :tcp, sources: [openvpn_sg, chefmgmt_sg] },
                       
                     ],)

security_groups.push(sg_name: svc_srv_security_group_name,
                     sg_rules: [
                       { port: 80, protocol: :tcp, sources: [web_srv_security_group_name] },
                       { port: 22, protocol: :tcp, sources: [openvpn_sg, chefmgmt_sg] },
                     ],)

security_groups.push(sg_name: data_srv_security_group_name,
                     sg_rules: [
                       { port: 5432, protocol: :tcp, sources: [web_srv_security_group_name, svc_srv_security_group_name, openvpn_sg, chefmgmt_sg] },
                       { port: 3306, protocol: :tcp, sources: [web_srv_security_group_name, svc_srv_security_group_name, openvpn_sg, chefmgmt_sg] }
                     ],)

security_groups.each do |sg|
  aws_security_group sg[:sg_name] do
    vpc vpc_id
    aws_tags aws_tags
    inbound_rules sg[:sg_rules]
  end
end




