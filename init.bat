@echo off

set rubickRoot=%HOMEDRIVE%%HOMEPATH%\.rubick

mkdir "%rubickRoot%"

copy /-y src\stubs\Rubick.yaml "%rubickRoot%\Rubick.yaml"
copy /-y src\stubs\after.sh "%rubickRoot%\after.sh"
copy /-y src\stubs\aliases "%rubickRoot%\aliases"

set rubickRoot=
echo Rubick initialized!