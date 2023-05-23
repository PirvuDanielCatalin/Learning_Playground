#!/usr/bin/env bash

# Take the IPS
source ../inventory/env_ire-test-env_22.sh

name_of_playbook="${1}"

# Start the clock
time_start=$(date +%s)

# Run the playbook
ansible-playbook -i "../inventory/Local&AWS.yml" ../playbooks/Utilities/${name_of_playbook}.yml

# Stop the clock
time_end=$(date +%s)

# Print the time
time=$((time_end - time_start))

echo "It took ${time} seconds to complete playbook"
