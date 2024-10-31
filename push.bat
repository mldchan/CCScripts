@echo off
:: Get the current date and time in the format you want
for /f "tokens=1-4 delims=/:" %%a in ('date /t & time /t') do (
    set month=%%a
    set day=%%b
    set year=%%c
    set hour=%%d
)

:: Format time to 24-hour format
if %hour% LSS 10 set hour=0%hour%
if %time:~6,2% LSS 12 set suffix=AM
if %time:~6,2% GTR 12 set suffix=PM

:: Change directory to your repo
cd /d "C:\path\to\your\repo"

:: Stage all changes
git add .

:: Commit with the formatted date and time
set commit_msg=Update on %year%/%month%/%day% at %hour%:00 %suffix%
git commit -m "%commit_msg%"

:: Push the commit to the remote repository
git push origin main

@echo Commit and push complete!
pause
