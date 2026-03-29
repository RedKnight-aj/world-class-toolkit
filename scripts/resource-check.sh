#!/bin/bash
# Resource Update Check Script
# Runs weekly to check all critical resources

LOG_FILE="/home/aj979515/.openclaw/workspace/memory/resource-checks.log"
DATE=$(date "+%Y-%m-%d %H:%M")

echo "=== Resource Check - $DATE ===" >> $LOG_FILE

# 1. OpenClaw Version
echo -n "OpenClaw: " >> $LOG_FILE
npm view openclaw version 2>/dev/null >> $LOG_FILE

# 2. Gateway Status
echo -n "Gateway: " >> $LOG_FILE
openclaw gateway status 2>&1 | grep -E "Runtime|state" | head -1 >> $LOG_FILE

# 3. Kilo Version
echo -n "Kilo: " >> $LOG_FILE
kilo --version 2>> $LOG_FILE

# 4. Disk Usage
echo -n "Disk: " >> $LOG_FILE
df -h / | awk 'NR==2 {print $5 " used"}' >> $LOG_FILE

echo "=== End Check ===" >> $LOG_FILE
echo "" >> $LOG_FILE

# Output to console
cat $LOG_FILE | tail -10
