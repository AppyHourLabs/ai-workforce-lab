#!/usr/bin/env python3
import os
import sys
import time
import requests
import argparse
from pathlib import Path
import base64

try:
    from google import genai
    from google.genai import types
except ImportError:
    print("Please install google-genai: pip install google-genai")
    sys.exit(1)

def extract_prompt(episode_file):
    with open(episode_file, 'r', encoding='utf-8') as f:
        content = f.read()
        
    marker = "**Veo 3 Prompt:** "
    if marker not in content:
        print(f"Error: Could not find '{marker}' in {episode_file}")
        sys.exit(1)
        
    prompt = content.split(marker)[1].strip()
    prompt = prompt.split("\n")[0].strip()
    return prompt

def main():
    parser = argparse.ArgumentParser(description="Generate Veo 3 B-roll from episode markdown.")
    parser.add_argument("episode_file", help="Path to the episode markdown file")
    parser.add_argument("output_path", nargs="?", default=None, help="Output MP4 path")
    parser.add_argument("--logo", help="Path to a logo image to use as the starting frame")
    
    args = parser.parse_args()
    
    episode_file = args.episode_file
    prompt = extract_prompt(episode_file)
    print(f"Extracted Prompt: {prompt}")
    
    output_path = args.output_path if args.output_path else episode_file.replace(".md", ".mp4")
    
    api_key = os.environ.get("GEMINI_API_KEY")
    if not api_key:
        print("Error: GEMINI_API_KEY environment variable is missing.")
        sys.exit(1)
        
    client = genai.Client(api_key=api_key)
    
    image_part = None
    if args.logo and os.path.exists(args.logo):
        print(f"Encoding logo {args.logo} for inline upload...")
        with open(args.logo, "rb") as f:
            image_data = f.read()
            
        b64_data = base64.b64encode(image_data).decode("utf-8")
        
        # The Veo API expects a generic 'image' struct containing these fields
        image_part = types.Image(
            image_bytes=image_data, 
            mime_type="image/png"
        )
    
    print("Sending video generation request to Veo 3.1...")
    try:
        source = types.GenerateVideosSource(
            prompt=prompt,
            image=image_part if image_part else None
        )
            
        operation = client.models.generate_videos(
            model="veo-3.1-generate-preview",
            source=source,
            config=types.GenerateVideosConfig(
                aspect_ratio="16:9"
            )
        )
    except Exception as e:
        print(f"Error generating video with Veo 3.1: {e}")
        try:
            print("Falling back to Veo 2.0...")
            operation = client.models.generate_videos(
                model="veo-2.0-generate-001",
                source=types.GenerateVideosSource(
                    prompt=prompt,
                    image=image_part if image_part else None
                ),
                config=types.GenerateVideosConfig(
                    aspect_ratio="16:9"
                )
            )
        except Exception as e2:
            print(f"Fallback error: {e2}")
            sys.exit(1)

    print("Generation started. Polling for completion (this takes ~1-3 minutes)...")
    
    while not operation.done:
        print(".", end="", flush=True)
        time.sleep(10)
        try:
            operation = client.operations.get(operation=operation)
        except Exception as e:
            print(f"\nPoll error: {e}")
            break
        
    print("\nGeneration complete!")
    
    if operation.error:
        print(f"Error from API: {operation.error}")
        sys.exit(1)
        
    try:
        video_uri = operation.result.generated_videos[0].video.uri
        print(f"Video URI: {video_uri}")
        
        print(f"Downloading video to {output_path}...")
        headers = {"x-goog-api-key": api_key}
        response = requests.get(video_uri, headers=headers)
        response.raise_for_status()
        
        with open(output_path, "wb") as f:
            f.write(response.content)
            
        print(f"Successfully saved to {output_path}")
        print(f"MEDIA: {Path(output_path).resolve()}")
        
    except Exception as e:
        print(f"Error downloading or processing result: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()
