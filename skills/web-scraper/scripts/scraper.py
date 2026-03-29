#!/usr/bin/env python3
"""
Elite Web Scraper - CLI Wrapper
Quick scraping without writing code.
"""

import argparse
import json
import sys
from pathlib import Path

# Check for scrapling - fallback to requests if not installed
try:
    from scrapling.fetchers import Fetcher, StealthyFetcher, DynamicFetcher
    from scrapling.spiders import Spider, Response
    SCRAPLING_AVAILABLE = True
except ImportError:
    SCRAPLING_AVAILABLE = False
    # Fallback to requests
    import requests


def parse_args():
    parser = argparse.ArgumentParser(description="Elite Web Scraper")
    parser.add_argument("url", help="Target URL")
    parser.add_argument("--selector", "-s", default="body", help="CSS selector")
    parser.add_argument("--stealth", action="store_true", help="Use stealth mode")
    parser.add_argument("--adaptive", "-a", action="store_true", help="Adaptive element tracking")
    parser.add_argument("--output", "-o", help="Output file")
    parser.add_argument("--format", "-f", choices=["json", "text", "markdown"], default="text",
                        help="Output format")
    parser.add_argument("--proxy", "-p", help="Proxy URL")
    return parser.parse_args()


def fetch_stealth(url, selector, adaptive=False, proxy=None):
    """Stealth fetch with Cloudflare bypass."""
    if not SCRAPLING_AVAILABLE:
        raise ImportError("scrapling not installed. Run: pip install scrapling[all]")
    
    if proxy:
        page = StealthyFetcher.fetch(url, proxy=proxy, solve_cloudflare=True)
    else:
        page = StealthyFetcher.fetch(url, solve_cloudflare=True)
    
    elements = page.css(selector, adaptive=adaptive)
    return elements


def fetch_basic(url, selector, adaptive=False, proxy=None):
    """Basic fetch."""
    if not SCRAPLING_AVAILABLE:
        # Fallback to requests
        response = requests.get(url)
        return response.text
    
    kwargs = {"proxy": proxy} if proxy else {}
    page = Fetcher.get(url, **kwargs)
    elements = page.css(selector, adaptive=adaptive)
    return elements


def main():
    args = parse_args()
    
    try:
        if args.stealth:
            results = fetch_stealth(args.url, args.selector, args.adaptive, args.proxy)
        else:
            results = fetch_basic(args.url, args.selector, args.adaptive, args.proxy)
        
        # Format output
        if args.format == "json":
            output = json.dumps(results.getall() if hasattr(results, 'getall') else [results], indent=2)
        elif args.format == "markdown":
            output = "\n\n".join([f"## Item {i}\n{r}" for i, r in enumerate(results.getall() if hasattr(results, 'getall') else [results], 1)])
        else:
            output = "\n".join(results.getall() if hasattr(results, 'getall') else [str(results)])
        
        # Save or print
        if args.output:
            Path(args.output).write_text(output)
            print(f"✓ Saved to {args.output}")
        else:
            print(output)
        
    except ImportError as e:
        print(f"Error: {e}", file=sys.stderr)
        print("\nInstall scrapling:", file=sys.stderr)
        print("  pip install scrapling 'scrapling[all]'", file=sys.stderr)
        sys.exit(1)
    except Exception as e:
        print(f"Error: {e}", file=sys.stderr)
        sys.exit(1)


if __name__ == "__main__":
    main()