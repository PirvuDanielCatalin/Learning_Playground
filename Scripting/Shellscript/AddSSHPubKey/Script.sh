#!/bin/bash

read -p "aws_profile: " aws_profile
read -p "aws_region: " aws_region

read -p "target_environment: " target_environment
read -p "target_key_file: " target_key_file

read -p "Press any key if you are ok with the values or Ctrl + C if you want to exit..." check

# List of target machines
target_nodes=$(
    aws ec2 describe-instances --profile "${aws_profile}" --region "${aws_region}" --output text \
        --filter "Name=instance-state-name,Values=running" "Name=tag:Name,Values=*${target_environment}*" \
        --query "Reservations[*].Instances[*].[PrivateIpAddress]"
) 

key_content=$(cat $target_key_file)

# Loop through each machine and add the SSH public key
for target_node in ${target_nodes[@]}
do
    ssh "ec2-user@${target_node}" 'echo "'${key_content}'" >> ~/.ssh/authorized_keys'
done
