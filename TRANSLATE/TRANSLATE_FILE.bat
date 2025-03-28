@echo off

rem  $Id: JackCompiler.bat,v 1.2 2014/05/10 00:52:43 marka Exp $
rem  mark.armbrust@pobox.com

setlocal

rem
set "INPUT_DIR=..\Source"
set "OUTPUT_DIR=..\Game"

rem
if not "%2"=="" goto :USAGE
if "%~1"=="/?" (
:USAGE
  echo Usage:
  echo     JackCompiler               Compiles all .jack files in the current
  echo                                 working directory.
  echo     JackCompiler DIRECTORY     Compiles all .jack files in DIRECTORY.
  echo     JackCompiler FILE.jack     Compiles FILE.jack to FILE.vm.
  exit /b
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
