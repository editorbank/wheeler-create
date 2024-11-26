@call ..\tests-common.cmd && echo on || exit /b 1

@if not exist ".tmp" md ".tmp"
jupyter nbconvert --to html --output-dir .tmp ./test_ipywidgets.ipynb
@for %%I in ( .tmp/test_ipywidgets.html ) do if not %%~zI geq 1000 (1>&2 echo Size error! & exit /b 1)
echo OK
