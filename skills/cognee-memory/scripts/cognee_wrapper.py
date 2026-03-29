import sys
import asyncio
import cognee
import argparse
import os

# Ensure API key is present (OpenAI or compatible)
# os.environ["LLM_API_KEY"] is expected

async def add(text):
    print(f"[Cognee] Adding text: {text[:50]}...")
    await cognee.add(text)
    print("[Cognee] Text added.")

async def cognify():
    print("[Cognee] Cognifying (building graph)...")
    await cognee.cognify()
    print("[Cognee] Cognify complete.")

async def search(query):
    print(f"[Cognee] Searching for: {query}")
    results = await cognee.search(query)
    print("[Cognee] Results:")
    for result in results:
        print(result)

async def main():
    parser = argparse.ArgumentParser(description="Cognee Memory Wrapper")
    subparsers = parser.add_subparsers(dest="command", required=True)

    add_parser = subparsers.add_parser("add")
    add_parser.add_argument("text", help="Text to add to memory")

    cognify_parser = subparsers.add_parser("cognify")

    search_parser = subparsers.add_parser("search")
    search_parser.add_argument("query", help="Search query")

    args = parser.parse_args()

    if args.command == "add":
        await add(args.text)
    elif args.command == "cognify":
        await cognify()
    elif args.command == "search":
        await search(args.query)

if __name__ == "__main__":
    asyncio.run(main())
