@echo off
setlocal enabledelayedexpansion

:: Get the current date and time
for /f "tokens=1-5 delims=/:- " %%d in ("%date% %time%") do (
    set year=%%d
    set month=%%e
    set day=%%f
    set hour=%%g
    set minute=%%h
)

:: Format the commit message
set commitMessage=Commit !year!/!month!/!day! at !hour!:!minute!

:: Change to the repository directory
cd /path/to/your/repo

:: Stage, commit, and push changes
git add .
git commit -m "!commitMessage!"
git push origin main
