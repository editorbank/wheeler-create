call ..\tests-common.cmd || exit /b 1

meltano lock --update --all || exit /b 1
meltano install || exit /b 1
meltano test || exit /b 1
for /F "usebackq" %%I in ( ` type meltano.yml ^| yq ".plugins[][].name" ` ) do meltano invoke %%I --help >nul || exit /b 1
echo OK
