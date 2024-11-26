@echo --- %~nx0 Start ...
::@for %%I in ( .pylibs ) do @set WHEELER_DIR=%%~dpnxI
@for %%I in ( .pylibs ) do @set WHEELER_DIR=%%~dpnxI
@set this_dir=%CD%
@for /F "usebackq" %%I in (`dir /b /a:d tests`) do @call :test1 %%I || (1>&2 echo ERROR in test %%I! & exit /b 1)
@echo --- %~nx0 - OK
@goto :eof

:test1
  @if not exist "tests\%~1\test.cmd" goto :eof
  
  @pushd "tests\%~1"
    @echo --- cd "%CD%"
    @call test.cmd && ( if exist clean.cmd call clean.cmd ) || exit /b 1
  @popd
  @echo --- "tests\%~1\test.cmd" - OK
@goto :eof

