#!/bin/bash

HOSTS_FILE="$HOME/etc/hosts"

while read -r ip host _; do
    [[ -z "$ip" || "$ip" =~ ^# ]] && continue

    if [[ "$ip" =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
        valid=true
        IFS='.' read -ra octets <<< "$ip"
        for octet in "${octets[@]}"; do
            if (( octet < 0 || octet > 255 )); then
                valid=false
                break
            fi
        done
        if [ "$valid" = true ]; then
            echo "Valid IP: $ip ($host)"
        else
            echo "Invalid IP: $ip ($host)"
        fi
    else
        echo "Invalid IP format: $ip ($host)"
    fi
done < "$HOSTS_FILE"
