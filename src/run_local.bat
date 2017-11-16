@ECHO OFF
REM on this page you can get some help with docker https://github.com/moby/moby/issues/22338
REM if you are using docker toolbox please be sure, that your files are under C:\Users folder if you want to share into docker containers
REM on windows you should mount absolute path to folder like: /c/Users/project/mysuperproject

REM on windows you probably should use another IP instead of 127.0.0.1 - you could get it with 'docker-machine ip default' command

docker-machine status | find /i "Stopped"
if not errorlevel 1 (
    docker-machine start
)
FOR /f "tokens=*" %%i IN ('docker-machine env --shell cmd default') DO @%%i

docker-machine status | find /i "Running"
if not errorlevel 0 (
    echo "Cannot start docker-machine"
    GOTO:EOF
)

docker network ls -f name=proxynet | find /i "proxynet"
if not errorlevel 1 (
    echo "Proxynet has already started"
) else (
    docker network create --driver=bridge proxynet
)

docker ps -f name=nginx-proxy-net | find /i "nginx-proxy-net"
if not errorlevel 1 (
    echo "Nginx already running"
) else (
    docker ps -a -f name=nginx-proxy-net | find /i "nginx-proxy-net"
    if not errorlevel 1 (
        docker start nginx-proxy-net
    ) else (
        docker run -d --network=proxynet --name=nginx-proxy-net -e HTTPS_METHOD=noredirect -p 80:80 -v /var/run/docker.sock:/tmp/docker.sock:ro -v %cd%/my_proxy.conf:/etc/nginx/conf.d/my_proxy.conf:ro jwilder/nginx-proxy
        docker run -d --network=proxynet --name=nginx-proxy-net -e HTTPS_METHOD=noredirect -p 80:80 -v /var/run/docker.sock:/tmp/docker.sock:ro jwilder/nginx-proxy
    )
)

if exists
docker-compose -f docker-compose-local.yml up -d --force-recreate --build