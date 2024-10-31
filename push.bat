@echo off
setlocal enabledelayedexpansion

:: Get the current date and time
for /f "tokens=1,2,3,4,5 delims=/-:. " %%a in ("%date% %time%") do (
    set day=%%a
    set month=%%b
    set year=%%c
    set hour=%%d
    set minute=%%e
)

:: Format the commit message
set commitMessage=Commit %year%/%month%/%day% at %hour%:%minute%

:: Change to the repository directory
cd /path/to/your/repo

:: Stage, commit, and push changes
git add .
git commit -m "%commitMessage%"
git push origin main
