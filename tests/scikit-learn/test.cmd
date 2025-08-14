@call ..\tests-common.cmd && echo on || exit /b 1

python test_scikit-learn.py || exit /b 1
echo OK
