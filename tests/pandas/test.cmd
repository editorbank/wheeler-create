@call ..\tests-common.cmd && echo on || exit /b 1

pytest tests || exit /b 1
echo OK
