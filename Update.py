import datetime
import os
import json
import requests
import threading

# Get the script's directory
script_path = os.path.dirname(os.path.abspath(__file__))

# Read the API key from the config file
config_path = os.path.join(script_path, "config.json")
if os.path.exists(config_path):
    with open(config_path, "r") as config_file:
        config = json.load(config_file)
        api_key = config["apiKey"]
else:
    api_key = input("Enter the API key: ")
    config = {"apiKey": api_key}
    with open(config_path, "w") as config_file:
        json.dump(config, config_file)

root_path = script_path
files = []
for root, _, filenames in os.walk(root_path):
    if ".git" in root or ".vscode" in root or ".venv" in root:
        continue
    for filename in filenames:
        files.append(os.path.join(root, filename))

def process_file(file_path):
    relative_path = os.path.relpath(file_path, root_path).replace("\\", "/")
    remote_path_file = f"cc/{relative_path}"
    remote_path_dir = "/".join(remote_path_file.split("/")[:-1]) + "/"
    download_url = f"https://mldkyt.nekoweb.org/{remote_path_file}"
    local_file_path = os.path.join(root_path, relative_path)

    remote_file_content = ""
    # Download the file
    try:
        response = requests.get(download_url)
        response.raise_for_status()
        remote_file_content = response.text
    except requests.exceptions.HTTPError as e:
        if e.response.status_code == 404:
            print(f"File '{relative_path}' not found on the server.")
        else:
            raise

    # Compare the file
    with open(local_file_path, "rb") as local_file:
        local_file_content = local_file.read()

    if remote_file_content.encode() == local_file_content:
        return
    else:
        print(f"File '{relative_path}' needs to be updated.")

    # Upload the file or folder
    upload_url = "https://nekoweb.org/api/files/upload"
    upload_params = {
        "pathname": "/" + remote_path_dir,
        "isFolder": False
    }
    headers = {
        "Authorization": api_key
    }
    upload_response = requests.post(upload_url, data=upload_params, headers=headers, files={"files": open(local_file_path, "rb")})

    # Check the upload response
    if upload_response.status_code == 200:
        print(f"File '{relative_path}' updated.")

def commit():
    current_time = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    commit_message = f"Update files - {current_time}"
    os.system("git add .")
    os.system(f"git commit -m \"{commit_message}\"")

# Start a thread for each file
threads = []
for file_path in files:
    thread = threading.Thread(target=process_file, args=(file_path,))
    thread.start()
    threads.append(thread)

threads.append(threading.Thread(target=commit))

print(f"Running {len(threads)} threads...")

# Wait for all threads to finish
for thread in threads:
    thread.join()