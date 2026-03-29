#!/usr/bin/env python3
"""
Free MCP Search Tool - Exa Search
"""

import os
import requests
import json
import sys

# Get API key from environment
EXA_API_KEY = os.environ.get("EXA_API_KEY", "")

def search(query, num_results=10):
    """Search using Exa AI"""
    if not EXA_API_KEY:
        return {"error": "No EXA_API_KEY set"}
    
    url = "https://api.exa.ai/search"
    headers = {
        "Authorization": f"Bearer {EXA_API_KEY}",
        "Content-Type": "application/json"
    }
    data = {
        "query": query,
        "numResults": num_results,
        "type": "auto"
    }
    
    try:
        resp = requests.post(url, headers=headers, json=data, timeout=10)
        results = resp.json()
        
        output = []
        for r in results.get("results", []):
            output.append({
                "title": r.get("title", ""),
                "url": r.get("url", ""),
                "snippet": r.get("snippet", "")[:200]
            })
        return {"results": output, "count": len(output)}
    except Exception as e:
        return {"error": str(e)}

if __name__ == "__main__":
    query = " ".join(sys.argv[1:]) if len(sys.argv) > 1 else "AI agents"
    print(f"Searching for: {query}")
    results = search(query)
    print(json.dumps(results, indent=2))
