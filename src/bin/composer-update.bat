@ECHO OFF

REM start docker
call %cd%\bin\docker-start.cmd

REM remove C:\ from current dir
SET dir=%cd:C:\=/%
REM replace backslash for normal slash
SET dir=/c%dir:\=/%/
ECHO %dir%
docker run --rm -v %dir%:/app composer/composer update
