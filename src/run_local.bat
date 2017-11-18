@ECHO OFF
REM on this page you can get some help with docker https://github.com/moby/moby/issues/22338
REM if you are using docker toolbox please be sure, that your files are under C:\Users folder if you want to share into docker containers
REM on windows you should mount absolute path to folder like: /c/Users/project/mysuperproject

REM on windows you probably should use another IP instead of 127.0.0.1 - you could get it with 'docker-machine ip default' command

docker-machine status | find /i "Stopped" >nul
if not errorlevel 1 (
    docker-machine start
)
FOR /f "tokens=*" %%i IN ('docker-machine env --shell cmd default') DO @%%i

docker-machine status | find /i "Running" >nul
if not errorlevel 0 (
    echo Cannot start docker-machine
    GOTO:EOF
)

docker network ls -f name=proxynet | find /i "proxynet" >nul
if not errorlevel 1 (
    echo Proxynet has already started
) else (
    docker network create --driver=bridge proxynet >nul
)

docker ps -f name=nginx-proxy-net | find /i "nginx-proxy-net" >nul
if not errorlevel 1 (
    echo Nginx already running
) else (
    docker ps -a -f name=nginx-proxy-net | find /i "nginx-proxy-net" >nul
    if not errorlevel 1 (
        docker start nginx-proxy-net
    ) else (
        docker run -d --network=proxynet --name=nginx-proxy-net -e HTTPS_METHOD=noredirect -p 80:80 -v /var/run/docker.sock:/tmp/docker.sock:ro -v %cd%/my_proxy.conf:/etc/nginx/conf.d/my_proxy.conf:ro jwilder/nginx-proxy
        docker run -d --network=proxynet --name=nginx-proxy-net -e HTTPS_METHOD=noredirect -p 80:80 -v /var/run/docker.sock:/tmp/docker.sock:ro jwilder/nginx-proxy
    )
)

if exist %1 (
    set docker_compose_file=%1
) else (
    echo 'Load default docker-compose.yml file'
    timeout 5 >nul
    set docker_compose_file=docker-compose-local.yml
)

if "%~2"=="" (
    set project_name=myproject
) else (
    set project_name=%2
)

docker-compose -p %project_name% -f %docker_compose_file% up -d --force-recreate --build >nul

FOR /F "tokens=* USEBACKQ" %%F IN (`docker exec -i %project_name%_webserver_1 printenv VIRTUAL_HOST`) DO (
    SET vhost=%%F
)

FOR /F "tokens=* USEBACKQ" %%F IN (`docker-machine ip default`) DO (
    SET ip=%%F
)
echo(
echo -------------------------------------------------------------------------------
echo ^|                                  IMPORTANT                                  ^|
echo -------------------------------------------------------------------------------
echo Do not forget add this line to your C:\Windows\System32\drivers\etc\hosts file:
echo %ip%       %vhost%
echo(
echo(


