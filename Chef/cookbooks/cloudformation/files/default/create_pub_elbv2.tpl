{
  "AWSTemplateFormatVersion" : "2010-09-09",

  "Description" : "AWS CloudFormation Template for Creating Application load balancers in the VPC",

  "Parameters" : {

    "ElbName" : {
      "Description": "ELB name",
      "Type": "String",
      "Description": "Name of the application loadbalancer"
    },

    "Subnet1" : {
      "Type" : "AWS::EC2::Subnet::Id",
      "Description" : "SubnetId of an public subnet (for availability zone a) in your Virtual Private Cloud (VPC)",
      "ConstraintDescription" : "must be an existing subnet in the selected Virtual Private Cloud."
    },

    "Subnet2" : {
      "Type" : "AWS::EC2::Subnet::Id",
      "Description" : "SubnetId of an public subnet (for availability zone a) in your Virtual Private Cloud (VPC)",
      "ConstraintDescription" : "must be an existing subnet in the selected Virtual Private Cloud."
    },

    "ElbSecurityGroup": {
      "Type" : "AWS::EC2::SecurityGroup::Id",
      "Description" : "Public ELB SecurityGroup in your Virtual Private Cloud (VPC)",
      "ConstraintDescription" : "must be an existing subnet in the selected Virtual Private Cloud."
    },

    "VpcId": {
      "Type" : "AWS::EC2::VPC::Id",
      "Description" : "Public ELB SecurityGroup in your Virtual Private Cloud (VPC)",
      "ConstraintDescription" : "must be an existing subnet in the selected Virtual Private Cloud."

    },

  },

"Resources" : {

    "loadBalancer" : {
      "Type": "AWS::ElasticLoadBalancingV2::LoadBalancer",
      "Properties": {
        "Scheme" : "internet-facing",
        "Subnets" : [{ "Ref" : "Subnet1" }, { "Ref" : "Subnet2" }],
        "LoadBalancerAttributes" : [
          { "Key" : "idle_timeout.timeout_seconds", "Value" : "50" },
          { "Key" : "deletion_protection.enabled", "Value" : "false" }
        ],
        "Name": {"Ref": "ElbName"},
        "SecurityGroups": [{"Ref": "ElbSecurityGroup"}]
      }
    },

    "TargetGroup1" : {
      "Type" : "AWS::ElasticLoadBalancingV2::TargetGroup",
      "Properties" : {
        "HealthCheckIntervalSeconds": 30,
        "HealthCheckProtocol": "HTTP",
        "HealthCheckTimeoutSeconds": 10,
        "HealthyThresholdCount": 4,
        "Matcher" : {
          "HttpCode" : "200"
        },
        "Name": {"Fn::Join" : ["-", [{"Ref" : "ElbName"}, "tg1"]]},
        "Port": 80,
        "Protocol": "HTTP",
        "TargetGroupAttributes": [{
          "Key": "deregistration_delay.timeout_seconds",
          "Value": "20"
        }],
        "UnhealthyThresholdCount": 5,
        "VpcId": {"Ref" : "VpcId"},
      }
    },

    "TargetGroup2" : {
      "Type" : "AWS::ElasticLoadBalancingV2::TargetGroup",
      "Properties" : {
        "HealthCheckIntervalSeconds": 30,
        "HealthCheckProtocol": "HTTPS",
        "HealthCheckTimeoutSeconds": 10,
        "HealthyThresholdCount": 4,
        "Matcher" : { 
          "HttpCode" : "200"
        },
        "Name": {"Fn::Join" : ["-", [{"Ref" : "ElbName"}, "tg2"]]},
        "Port": 443,
        "Protocol": "HTTPS",
        "TargetGroupAttributes": [{
          "Key": "deregistration_delay.timeout_seconds",
          "Value": "20"
        }],
        "UnhealthyThresholdCount": 5,
        "VpcId": {"Ref" : "VpcId"},
      }
    },

    "Listener1": {
      "Type": "AWS::ElasticLoadBalancingV2::Listener",
      "Properties": {
        "DefaultActions": [{
          "Type": "forward",
          "TargetGroupArn": { "Ref": "TargetGroup1" }
        }],
        "LoadBalancerArn": { "Ref": "loadBalancer" },
        "Port": "80",
        "Protocol": "HTTP"
      }
    },
  }

}
