#!/bin/bash
#
# Gets mem usage & instance id, pushes info into CloudWatch metric
#
# Get memory usage
mem=$(ps -C httpd -O rss | gawk '{ count ++; sum += $2 }; END {count --; print sum/1024 ;};')
# Get instance id
instance_id=$(curl -s -w '\n' http://169.254.169.254/latest/meta-data/instance-id)

# Push metric into CloudWatch:
aws cloudwatch put-metric-data --namespace HttpServerMetrics --metric-name HttpServerMemUtilization --dimension InstanceId=$instance_id --value $mem --unit "Megabytes"
