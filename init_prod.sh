#!/bin/bash

ec2_id=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)

# remove from target group
aws elbv2 deregister-targets \
--target-group-arn arn:aws:elasticloadbalancing:eu-west-3:644435390668:loadbalancer/app/shovalALB/123b9fb546c15f24 \
--targets Id="${ec2_id}"

sleep 3

# update the prod env
docker stop prod && docker rm prod
docker pull 644435390668.dkr.ecr.eu-west-3.amazonaws.com/shoval_toxi:toxictypo-alb 
docker run -d -p 80:8080 --name prod 644435390668.dkr.ecr.eu-west-3.amazonaws.com/shoval_toxi:toxictypo-alb

sleep 7

curl -X POST -F "name=${ec2_id}" "http://localhost/api/name"

# add back to target group
aws elbv2 register-targets \
--target-group-arn arn:aws:elasticloadbalancing:eu-west-3:644435390668:loadbalancer/app/shovalALB/123b9fb546c15f24 \
--targets Id="${ec2_id}"

sleep 12 