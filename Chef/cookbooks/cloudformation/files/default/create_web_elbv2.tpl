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
    "TargetInstance1": {
      "Type" : "AWS::EC2::Instance::Id",
        "Description" : "List of ec2 instances",
        "ConstraintDescription" : "must be an existing instance in the selected Virtual Private Cloud."
    },
    "TargetInstance2": {
      "Type" : "AWS::EC2::Instance::Id",
        "Description" : "List of ec2 instances",
        "ConstraintDescription" : "must be an existing instance in the selected Virtual Private Cloud."
    },
    "TargetInstance3": {
      "Type" : "AWS::EC2::Instance::Id",
        "Description" : "List of ec2 instances",
        "ConstraintDescription" : "must be an existing instance in the selected Virtual Private Cloud."
    },
    "TargetInstance4": {
      "Type" : "AWS::EC2::Instance::Id",
        "Description" : "List of ec2 instances",
        "ConstraintDescription" : "must be an existing instance in the selected Virtual Private Cloud."
    },

  },

"Resources" : {

    "loadBalancer" : {
      "Type": "AWS::ElasticLoadBalancingV2::LoadBalancer",
      "DeletionPolicy" : "Retain",
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
      "DeletionPolicy" : "Retain",
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
        "Targets": [
          { "Id": {"Ref" : "TargetInstance1"}, "Port": 80 },
          { "Id": {"Ref" : "TargetInstance2"}, "Port": 80 },
          { "Id": {"Ref" : "TargetInstance3"}, "Port": 80 },
          { "Id": {"Ref" : "TargetInstance4"}, "Port": 80 },
        ],
        "UnhealthyThresholdCount": 5,
        "VpcId": {"Ref" : "VpcId"},
      }
    },

    "TargetGroup2" : {
      "Type" : "AWS::ElasticLoadBalancingV2::TargetGroup",
      "DeletionPolicy" : "Retain",
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
        "Targets": [
          { "Id": {"Ref" : "TargetInstance1"}, "Port": 443 },
          { "Id": {"Ref" : "TargetInstance2"}, "Port": 443 },
          { "Id": {"Ref" : "TargetInstance3"}, "Port": 443 },
          { "Id": {"Ref" : "TargetInstance4"}, "Port": 443 }
        ],
        "UnhealthyThresholdCount": 5,
        "VpcId": {"Ref" : "VpcId"},
      }
    },

    "Listener1": {
      "Type": "AWS::ElasticLoadBalancingV2::Listener",
      "DeletionPolicy" : "Retain",
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
