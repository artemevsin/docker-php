@ECHO OFF
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