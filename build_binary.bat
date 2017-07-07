setlocal EnableDelayedExpansion

@echo off

set TOPLEVEL=%cd%
set OLDPATH=%path%

set BOOTSTRAP_TOOLSET=vc14
set B2_TOOLSET=msvc-14.0
call "%VS140COMNTOOLS%..\..\VC\bin\amd64\vcvars64.bat"
if !errorlevel! neq 0 exit /b !errorlevel!


call bootstrap.bat %BOOTSTRAP_TOOLSET%
if !errorlevel! neq 0 exit /b !errorlevel!

b2 debug headers --user-config="%TOPLEVEL%/boost-user-config.jam" -sBOOST_ROOT=. -sZLIB_SOURCE="%TOPLEVEL%/zlib" --toolset=%B2_TOOLSET% cxxflags="-D_ITERATOR_DEBUG_LEVEL=1" address-model=64 link=static runtime-link=shared --with-system --with-filesystem --with-thread --with-date_time --with-chrono --with-regex --with-iostreams stage
if !errorlevel! neq 0 exit /b !errorlevel!

b2 release headers --user-config="%TOPLEVEL%/boost-user-config.jam" -sBOOST_ROOT=. -sZLIB_SOURCE="%TOPLEVEL%/zlib" --toolset=%B2_TOOLSET% address-model=64 link=static runtime-link=shared --with-system --with-filesystem --with-thread --with-date_time --with-chrono --with-regex --with-iostreams stage
if !errorlevel! neq 0 exit /b !errorlevel!

set PATH=%OLDPATH%

