#!/bin/bash
# RedKnight Weekly Self-Review Script
# Analyzes memory logs to identify patterns and improvements
# Runs weekly - finds what works and what doesn't

LOG_FILE="/home/aj979515/.openclaw/workspace/memory/weekly-review.log"
MEMORY_DIR="/home/aj979515/.openclaw/workspace/memory"

echo "=== RedKnight Weekly Self-Review ===" >> $LOG_FILE
echo "Date: $(date)" >> $LOG_FILE
echo "" >> $LOG_FILE

# 1. Count events this week
echo "1. Events This Week:" >> $LOG_FILE
grep -c "SYSTEM:" $MEMORY_DIR/2026-02-*.md 2>/dev/null >> $LOG_FILE || echo "0" >> $LOG_FILE

# 2. Check what worked
echo "" >> $LOG_FILE
echo "2. What Worked:" >> $LOG_FILE
grep -i "success\|fixed\|working\|good" $MEMORY_DIR/2026-02-*.md 2>/dev/null | tail -5 >> $LOG_FILE || echo "Nothing recorded" >> $LOG_FILE

# 3. Check what failed
echo "" >> $LOG_FILE
echo "3. What Failed:" >> $LOG_FILE
grep -i "error\|fail\|timeout\|broken" $MEMORY_DIR/2026-02-*.md 2>/dev/null | tail -5 >> $LOG_FILE || echo "Nothing recorded" >> $LOG_FILE

# 4. Check sub-agent usage
echo "" >> $LOG_FILE
echo "4. Sub-agent Usage:" >> $LOG_FILE
grep -i "spawn\|delegation\|agent" $MEMORY_DIR/2026-02-*.md 2>/dev/null | tail -5 >> $LOG_FILE || echo "Nothing recorded" >> $LOG_FILE

# 5. Recommendations
echo "" >> $LOG_FILE
echo "5. Recommendations:" >> $LOG_FILE
echo "- Review failed tasks and add to prevention list" >> $LOG_FILE
echo "- Document successful patterns" >> $LOG_FILE
echo "- Update SOUL.md if needed" >> $LOG_FILE

echo "" >> $LOG_FILE
echo "=== End Review ===" >> $LOG_FILE
echo "" >> $LOG_FILE

echo "Weekly review complete: $LOG_FILE"
