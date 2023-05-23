#!/usr/bin/env bash

# Take the IPS
source ../inventory/env_ire-test-env_22.sh

name_of_playbook="${1}"

avg_time=0
for times in {1..5}
do
    echo "#### ${times} ####"
    # Start the clock
    time_start=$(date +%s)

    # Run the playbook
    ansible-playbook -i "../inventory/Local&AWS.yml" ../playbooks/CASE${name_of_playbook}/main.yml

    # Stop the clock
    time_end=$(date +%s)

    # Print the time
    time=$((time_end - time_start))

    let avg_time+=time
done

let avg_time/=5

echo "It took an average of ${avg_time} seconds to complete playbook"
