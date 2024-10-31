import datetime
import os

now = datetime.datetime.now()
current_time = now.strftime("%Ytoshi%mgatsu%dhi %H:%M:%S")
current_time = current_time.replace("toshi", "年")
current_time = current_time.replace("gatsu", "月")
current_time = current_time.replace("hi", "日")
commit_message = f"Update files - {current_time}"
os.system("git add .")
os.system(f"git commit -m \"{commit_message}\"")
os.system("git push")