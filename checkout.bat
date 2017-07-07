setlocal EnableDelayedExpansion

SET the_ref=fl4re-dev


@echo off
REM echo without space & newline.  Gotta Love MS-DOS
echo|set /p dummyName="https://%GH_SB_USER%:%GH_SB_PASS%@github.com">gh.credentials || exit /b 1
@echo on

REM add credentials temporarily
git config --global credential.helper "store --file=\"%WORKSPACE%\gh.credentials\"" || exit /b 1


pushd .
cd boost

REM verify this is a git repo and exit with error if not
git rev-parse --is-inside-work-tree || exit /b 1


REM fetch & checkout

REM git fetch
git -c core.askpass=true fetch --tags --progress https://github.com/fl4re/boost.git %the_ref% || exit /b 1

git reset --hard || exit /b 1
git clean -fx || exit /b 1
git submodule foreach --recursive git reset --hard || exit /b 1
git submodule foreach --recursive git clean -fx || exit /b 1

REM submodules
git submodule sync --recursive || exit /b 1
git submodule update --init --recursive || exit /b 1

popd


REM remove credentials
git config --global --remove-section credential || exit /b 1

rm gh.credentials
