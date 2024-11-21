call ..\tests-common.cmd || exit 1

meltano lock --update --all || exit 1
meltano install || exit 1
meltano test || exit 1
for /F "usebackq" %%I in ( ` type meltano.yml ^| yq ".plugins[][].name" ` ) do meltano invoke %%I --help >nul || exit 1
echo OK
