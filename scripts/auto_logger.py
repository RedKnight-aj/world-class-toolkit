#!/usr/bin/env python3
"""
RedKnight Auto-Logger v1.0
Automatically logs important events to memory layers
Based on 2026 best practices: "Store signal, not noise"
"""

import os
import json
import sqlite3
from datetime import datetime
from pathlib import Path

# Configuration
WORKSPACE = Path("/home/aj979515/.openclaw/workspace")
LANCEDB_PATH = WORKSPACE / "memory" / "lancedb"
MEMORY_PATH = WORKSPACE / "memory"

# Importance triggers (from auto-logging-plan.md)
IMPORTANCE_TRIGGERS = {
    # HIGH priority (0.8-1.0)
    "remember": 0.95,
    "always": 0.9,
    "prefer": 0.9,
    "like": 0.85,
    "hate": 0.85,
    "goal": 0.9,
    "working on": 0.85,
    "decided": 0.85,
    "chose": 0.8,
    "correction": 0.9,
    "actually": 0.85,
    "wrong": 0.8,
    # MEDIUM priority (0.6-0.79)
    "research": 0.7,
    "found": 0.7,
    "discovered": 0.7,
    "upgraded": 0.75,
    "fixed": 0.7,
    "implemented": 0.7,
    "created": 0.65,
    "new": 0.6,
}

def calculate_importance(text: str) -> float:
    """Calculate importance score for text"""
    text_lower = text.lower()
    score = 0.5  # baseline
    
    for trigger, weight in IMPORTANCE_TRIGGERS.items():
        if trigger in text_lower:
            score = max(score, weight)
    
    return score

def classify_priority(text: str) -> str:
    """Classify text into HIGH/MEDIUM/LOW priority"""
    score = calculate_importance(text)
    
    if score >= 0.8:
        return "HIGH"
    elif score >= 0.6:
        return "MEDIUM"
    else:
        return "LOW"

def log_to_lancedb_facts(key: str, value: str, category: str = "auto_logged", importance: int = 8):
    """Log HIGH priority facts to LanceDB"""
    try:
        import lancedb
        
        db = lancedb.connect(str(LANCEDB_PATH))
        table = db.open_table("facts")
        
        # Check if key already exists
        df = table.to_pandas()
        existing = df[df['key'] == key]
        
        if not existing.empty:
            # Update existing
            print(f"  [INFO] Key '{key}' already exists, skipping")
            return False
        
        # Add new fact
        data = [{
            "key": key,
            "value": value,
            "category": category,
            "importance": importance,
            "created_at": datetime.now().isoformat(),
            "updated_at": datetime.now().isoformat()
        }]
        
        table.add(data)
        print(f"  [LOGGED] {key}: {value}")
        return True
        
    except Exception as e:
        print(f"  [ERROR] Failed to log to LanceDB: {e}")
        return False

def log_to_daily_memory(event_type: str, description: str, details: str = ""):
    """Log MEDIUM priority to daily memory"""
    try:
        today = datetime.now().strftime("%Y-%m-%d")
        memory_file = MEMORY_PATH / f"{today}.md"
        
        # Read existing content
        if memory_file.exists():
            content = memory_file.read_text()
        else:
            content = f"# {today}\n\n"
        
        # Add new entry
        timestamp = datetime.now().strftime("%H:%M")
        entry = f"\n## {timestamp} - {event_type}\n- {description}"
        if details:
            entry += f"\n  - {details}"
        
        content += entry
        
        # Write back
        memory_file.write_text(content)
        print(f"  [LOGGED] Daily memory: {event_type}")
        return True
        
    except Exception as e:
        print(f"  [ERROR] Failed to log to daily memory: {e}")
        return False

def process_event(text: str, event_type: str = "general", auto_key: str = None):
    """Process a single event and route to appropriate storage"""
    priority = classify_priority(text)
    
    print(f"[AUTO-LOG] Priority: {priority}")
    print(f"  Text: {text[:100]}...")
    
    if priority == "HIGH":
        if auto_key:
            log_to_lancedb_facts(auto_key, text, category=event_type, importance=9)
        else:
            # Extract key from text
            key = f"auto_{datetime.now().strftime('%Y%m%d_%H%M%S')}"
            log_to_lancedb_facts(key, text, category=event_type, importance=8)
    
    elif priority == "MEDIUM":
        log_to_daily_memory(event_type, text[:200])
    
    # LOW priority - skip (store signal, not noise)
    else:
        print(f"  [SKIPPED] Low importance")
    
    return priority

def log_user_preference(preference_type: str, value: str):
    """Convenience function for logging user preferences"""
    return log_to_lancedb_facts(
        key=f"user_{preference_type}",
        value=value,
        category="user_preference",
        importance=10
    )

def log_system_change(change_type: str, description: str):
    """Convenience function for logging system changes"""
    return log_to_daily_memory(
        event_type=f"SYSTEM: {change_type}",
        description=description
    )

# CLI interface
if __name__ == "__main__":
    import sys
    
    if len(sys.argv) < 2:
        print("RedKnight Auto-Logger v1.0")
        print("Usage:")
        print("  python auto_logger.py log <text>")
        print("  python auto_logger.py pref <type> <value>")
        print("  python auto_logger.py system <type> <description>")
        sys.exit(1)
    
    command = sys.argv[1]
    
    if command == "log":
        text = " ".join(sys.argv[2:])
        process_event(text)
    
    elif command == "pref":
        if len(sys.argv) < 4:
            print("Usage: python auto_logger.py pref <type> <value>")
            sys.exit(1)
        pref_type = sys.argv[2]
        value = sys.argv[3]
        log_user_preference(pref_type, value)
    
    elif command == "system":
        if len(sys.argv) < 4:
            print("Usage: python auto_logger.py system <type> <description>")
            sys.exit(1)
        change_type = sys.argv[2]
        description = " ".join(sys.argv[3:])
        log_system_change(change_type, description)
    
    else:
        print(f"Unknown command: {command}")
        sys.exit(1)
