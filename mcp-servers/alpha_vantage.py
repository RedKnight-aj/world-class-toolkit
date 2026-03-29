#!/usr/bin/env python3
"""
Free MCP Financial Data Tool - Alpha Vantage
"""

import os
import requests
import json
import sys

# Get API key from environment
ALPHA_VANTAGE_KEY = os.environ.get("ALPHA_VANTAGE_KEY", "")

def get_quote(symbol):
    """Get stock quote"""
    if not ALPHA_VANTAGE_KEY:
        return {"error": "No ALPHA_VANTAGE_KEY set"}
    
    url = f"https://www.alphavantage.co/query"
    params = {
        "function": "GLOBAL_QUOTE",
        "symbol": symbol,
        "apikey": ALPHA_VANTAGE_KEY
    }
    
    try:
        resp = requests.get(url, params=params, timeout=10)
        data = resp.json()
        
        if "Global Quote" in data:
            quote = data["Global Quote"]
            return {
                "symbol": quote.get("01. symbol", ""),
                "price": quote.get("05. price", ""),
                "change": quote.get("09. change", ""),
                "change_percent": quote.get("10. change percent", "")
            }
        return data
    except Exception as e:
        return {"error": str(e)}

def search_symbol(keywords):
    """Search for stock symbols"""
    if not ALPHA_VANTAGE_KEY:
        return {"error": "No ALPHA_VANTAGE_KEY set"}
    
    url = "https://www.alphavantage.co/query"
    params = {
        "function": "SYMBOL_SEARCH",
        "keywords": keywords,
        "apikey": ALPHA_VANTAGE_KEY
    }
    
    try:
        resp = requests.get(url, params=params, timeout=10)
        data = resp.json()
        
        results = []
        if "bestMatches" in data:
            for match in data["bestMatches"][:5]:
                results.append({
                    "symbol": match.get("1. symbol", ""),
                    "name": match.get("2. name", ""),
                    "type": match.get("3. type", "")
                })
        return {"results": results}
    except Exception as e:
        return {"error": str(e)}

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python alpha_vantage.py <command> <args>")
        print("Commands: quote <symbol>, search <keywords>")
        sys.exit(1)
    
    cmd = sys.argv[1]
    
    if cmd == "quote" and len(sys.argv) > 2:
        print(json.dumps(get_quote(sys.argv[2]), indent=2))
    elif cmd == "search" and len(sys.argv) > 2:
        print(json.dumps(search_symbol(" ".join(sys.argv[2:])), indent=2))
    else:
        print("Usage: python alpha_vantage.py <command> <args>")
