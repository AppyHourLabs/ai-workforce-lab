#!/usr/bin/env python3
import os
import sys
import argparse
from pathlib import Path
import google.oauth2.credentials
import google_auth_oauthlib.flow
from googleapiclient.discovery import build
from googleapiclient.http import MediaFileUpload
from google.auth.transport.requests import Request

# If modifying these scopes, delete the file token.json.
SCOPES = ['https://www.googleapis.com/auth/youtube.upload']

def extract_episode_details(episode_file):
    with open(episode_file, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Simple extraction logic for Title and Description
    # We assume the title is the first H1
    title = "Appy Hour Labs - AI Workforce Lab"
    for line in content.split('\n'):
        if line.startswith('# 🎬 Episode'):
            title = line.replace('# 🎬 ', '').strip()
            break

    # We can craft a standard description with a link
    basename = Path(episode_file).name
    url = f"https://github.com/AppyHourLabs/ai-workforce-lab/blob/main/DOCS/SHOW/episodes/{basename}"
    
    description = (
        f"Read the full episode log here: {url}\n\n"
        "AI Workforce Lab is a public experiment deploying AI agents as persistent team members with real responsibilities.\n"
        "Follow along: https://github.com/AppyHourLabs/ai-workforce-lab\n\n"
        "#AI #AgenticWorkforce #Engineering #AppyHourLabs"
    )
    
    return title, description

def authenticate():
    creds = None
    # The file token.json stores the user's access and refresh tokens, and is
    # created automatically when the authorization flow completes for the first time.
    token_path = 'youtube_token.json'
    client_secret_path = 'youtube_client_secret.json'
    
    if os.path.exists(token_path):
        creds = google.oauth2.credentials.Credentials.from_authorized_user_file(token_path, SCOPES)
        
    # If there are no (valid) credentials available, let the user log in.
    if not creds or not creds.valid:
        if creds and creds.expired and creds.refresh_token:
            creds.refresh(Request())
        else:
            if not os.path.exists(client_secret_path):
                print(f"Error: {client_secret_path} not found.")
                print("Please create an OAuth 2.0 Client ID (Desktop App) in Google Cloud Console, download the JSON, and save it as youtube_client_secret.json here.")
                sys.exit(1)
                
            flow = google_auth_oauthlib.flow.InstalledAppFlow.from_client_secrets_file(
                client_secret_path, SCOPES)
            creds = flow.run_local_server(port=0)
            
        # Save the credentials for the next run
        with open(token_path, 'w') as token:
            token.write(creds.to_json())
            
    return build('youtube', 'v3', credentials=creds)

def main():
    parser = argparse.ArgumentParser(description='Upload a generated Veo video to YouTube.')
    parser.add_argument('--video', required=True, help='Path to the video file (.mp4)')
    parser.add_argument('--episode', required=True, help='Path to the episode markdown file')
    args = parser.parse_args()

    title, description = extract_episode_details(args.episode)
    print(f"Preparing to upload:\nTitle: {title}\nDescription snippet: {description[:50]}...")

    youtube = authenticate()

    body = {
        'snippet': {
            'title': title[:100],  # YouTube max title length is 100
            'description': description,
            'tags': ['AI', 'AgenticWorkforce', 'AppyHourLabs', 'SoftwareEngineering'],
            'categoryId': '28' # Science & Technology
        },
        'status': {
            'privacyStatus': 'public' # or 'unlisted' for safety
        }
    }

    # Call the API's videos.insert method to create and upload the video.
    insert_request = youtube.videos().insert(
        part=','.join(body.keys()),
        body=body,
        media_body=MediaFileUpload(args.video, chunksize=-1, resumable=True)
    )

    print("Uploading video...")
    response = None
    while response is None:
        status, response = insert_request.next_chunk()
        if status:
            print(f"Uploaded {int(status.progress() * 100)}%")

    print("Upload Complete!")
    print(f"Video ID: {response['id']}")
    print(f"YouTube URL: https://youtu.be/{response['id']}")

if __name__ == '__main__':
    main()
