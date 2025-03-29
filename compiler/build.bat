@echo off

rem  $Id: JackCompiler.bat,v 1.2 2014/05/10 00:52:43 marka Exp $
rem  mark.armbrust@pobox.com

setlocal

rem
set "INPUT_DIR=..\src"
set "OUTPUT_DIR=..\game"

rem
if not "%2"=="" goto :USAGE
if "%~1"=="/?" (
:USAGE
  echo Usage:
  echo     JackCompiler               - compiles all .jack files in the Source directory
  exit /b
)

rem Delete previous .vm files in the output directory
if exist "%OUTPUT_DIR%\*.vm" (
    echo Deleting old .vm files in "%OUTPUT_DIR%"...
    del /q "%OUTPUT_DIR%\*.vm"
)

echo Compiling "%INPUT_DIR%"

java -classpath "%CLASSPATH%;bin/classes;bin/lib/Hack.jar;bin/lib/Compilers.jar" ^
  Hack.Compiler.JackCompiler "%INPUT_DIR%"

popd

if not exist "%OUTPUT_DIR%" mkdir "%OUTPUT_DIR%"

move "%INPUT_DIR%\*.vm" "%OUTPUT_DIR%" >nul 2>&1

if %ERRORLEVEL% NEQ 0 (
    echo Error moving files. Check paths.
) else (
    echo Files have been successfully saved to %OUTPUT_DIR%.
)