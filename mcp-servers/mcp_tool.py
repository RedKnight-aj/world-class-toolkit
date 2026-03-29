#!/usr/bin/env python3
"""
Universal MCP Tool - Combined utilities
"""

import os
import requests
import json
import sys
import subprocess
from datetime import datetime

# Configuration
EXA_API_KEY = os.environ.get("EXA_API_KEY", "")
ALPHA_VANTAGE_KEY = os.environ.get("ALPHA_VANTAGE_KEY", "")
BRAVE_API_KEY = os.environ.get("BRAVE_API_KEY", "")

def exa_search(query, num_results=10):
    """Exa AI search"""
    if not EXA_API_KEY:
        return {"error": "No EXA_API_KEY set"}
    
    url = "https://api.exa.ai/search"
    headers = {"Authorization": f"Bearer {EXA_API_KEY}", "Content-Type": "application/json"}
    
    try:
        resp = requests.post(url, headers=headers, json={"query": query, "numResults": num_results}, timeout=15)
        results = resp.json().get("results", [])
        return [{"title": r.get("title", ""), "url": r.get("url", ""), "snippet": r.get("snippet", "")[:200]} for r in results]
    except Exception as e:
        return {"error": str(e)}

def brave_search(query, num_results=10):
    """Brave Search"""
    if not BRAVE_API_KEY:
        return {"error": "No BRAVE_API_KEY set"}
    
    url = "https://api.search.brave.com/res/v1/web/search"
    headers = {"Accept": "application/json", "X-Subscription-Token": BRAVE_API_KEY}
    params = {"q": query, "count": num_results}
    
    try:
        resp = requests.get(url, headers=headers, params=params, timeout=15)
        data = resp.json()
        results = data.get("web", {}).get("results", [])
        return [{"title": r.get("title", ""), "url": r.get("url", ""), "snippet": r.get("description", "")[:200]} for r in results]
    except Exception as e:
        return {"error": str(e)}

def stock_quote(symbol):
    """Alpha Vantage stock quote"""
    if not ALPHA_VANTAGE_KEY:
        return {"error": "No ALPHA_VANTAGE_KEY set"}
    
    url = "https://www.alphavantage.co/query"
    params = {"function": "GLOBAL_QUOTE", "symbol": symbol, "apikey": ALPHA_VANTAGE_KEY}
    
    try:
        resp = requests.get(url, params=params, timeout=10)
        data = resp.json()
        quote = data.get("Global Quote", {})
        if quote:
            return {"symbol": quote.get("01. symbol", ""), "price": quote.get("05. price", ""), "change": quote.get("09. change", "")}
        return {"error": "No data"}
    except Exception as e:
        return {"error": str(e)}

def web_fetch(url):
    """Simple web fetcher"""
    try:
        resp = requests.get(url, timeout=10, headers={"User-Agent": "Mozilla/5.0"})
        return {"content": resp.text[:2000], "status": resp.status_code}
    except Exception as e:
        return {"error": str(e)}

def run_command(cmd):
    """Run shell command"""
    try:
        result = subprocess.run(cmd, shell=True, capture_output=True, text=True, timeout=30)
        return {"stdout": result.stdout[:2000], "stderr": result.stderr[:500], "returncode": result.returncode}
    except Exception as e:
        return {"error": str(e)}

# Main handler
if __name__ == "__main__":
    args = sys.argv[1:]
    if not args:
        print("Usage: mcp_tool.py <command> [args]")
        print("Commands: exa <query>, brave <query>, stock <symbol>, fetch <url>, run <command>")
        sys.exit(1)
    
    cmd = args[0]
    
    if cmd == "exa" and len(args) > 1:
        print(json.dumps(exa_search(" ".join(args[1:])), indent=2))
    elif cmd == "brave" and len(args) > 1:
        print(json.dumps(brave_search(" ".join(args[1:])), indent=2))
    elif cmd == "stock" and len(args) > 1:
        print(json.dumps(stock_quote(args[1].upper()), indent=2))
    elif cmd == "fetch" and len(args) > 1:
        print(json.dumps(web_fetch(args[1]), indent=2))
    elif cmd == "run" and len(args) > 1:
        print(json.dumps(run_command(" ".join(args[1:])), indent=2))
    else:
        print("Unknown command or missing args")
