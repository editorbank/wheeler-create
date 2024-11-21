call ..\tests-common.cmd && echo on || exit /b 1

@REM meltano lock --update --all || exit /b 1
meltano install || exit /b 1
@REM meltano test || exit /b 1
@REM for /F "usebackq" %%I in ( ` type meltano.yml ^| yq ".plugins[][].name" ` ) do meltano invoke %%I --help >nul || exit /b 1
echo OK
