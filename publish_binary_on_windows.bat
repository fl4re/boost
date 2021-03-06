setlocal EnableDelayedExpansion

git rev-parse --is-inside-work-tree
if errorlevel 1 exit /b %errorlevel% 

call npm install
if errorlevel 1 exit /b %errorlevel%

call npm --no-git-tag-version version patch
if errorlevel 1 exit /b %errorlevel%

call node_modules\.bin\prades publish -v
if errorlevel 1 exit /b %errorlevel% 

exit /b 0
