#!/bin/bash

LOG_FILE="/var/log/nginx/access.log"
OUTPUT_FILE="/var/log/nginx/access_by_hour.log"

# 시간별로 IP 카운트를 계산합니다.
awk '{
    split($4, a, ":");
    hour = substr(a[2], 1, 2);
    ip = $1;
    count[ip" "hour]++;
}
END {
    for (entry in count) {
        print entry, count[entry];
    }
}' $LOG_FILE > $OUTPUT_FILE
