@set PIP_EXE=python3 .\.pylibs\pip.pyz
@set PYTHON_VERSION=3.10.10
@set PTH_NAME=python310
@call :main %* && echo %~n0 - OK || echo %~n0 - FAIL
@goto :eof

:print_help_and_exit
  @echo.
  @echo.Use: %~n0 ^<libname^|requirement_file^|folder_with_requirement_files^>
  @echo.For example:
  @echo.  %~n0 .\requirement
  @echo.  %~n0 .\requirement\a1.requirement.txt
  @echo.  %~n0 numpy
  @echo.  %~n0 numpy==1.24.3
  @exit 1;
@goto :eof

:download_direct
  @if exist .\.pylibs\%1 @goto :eof
  @echo Download %2 to %1 ...
  @echo Found link %2 >>.\.log\%RANDOM%%RANDOM%%RANDOM%.log
  @curl -ks --fail -o .\.pylibs\%1 %2
  @if %ERRORLEVEL% neq 0 (echo CURL_ERROR:%ERRORLEVEL% & exit /b %ERRORLEVEL%)
@goto :eof

:download_init
  @set PYTHONHOME=
  @set PYTHONPATH=
  @if not exist .\.log md .\.log
  @if not exist .\.pylibs md .\.pylibs
  @call :download_direct pip.pyz https://bootstrap.pypa.io/pip/pip.pyz
  @call :download_direct python-%PYTHON_VERSION%-embed-win_amd64.zip https://www.python.org/ftp/python/%PYTHON_VERSION%/python-%PYTHON_VERSION%-embed-amd64.zip
  @if exist .python-embed\python.exe goto :download_init_2
    @powershell -Command "Expand-Archive .\.pylibs\python-%PYTHON_VERSION%-embed-win_amd64.zip -DestinationPath .python-embed"
    @if exist .python-embed\%PTH_NAME%._pth.bak goto :download_init_4
      @move  .python-embed\%PTH_NAME%._pth .python-embed\%PTH_NAME%._pth.bak
      @echo Lib\site-packages>.python-embed\%PTH_NAME%._pth
      @type .python-embed\%PTH_NAME%._pth.bak>>.python-embed\%PTH_NAME%._pth
    :download_init_4
    @set PYTHONPATH=
    .python-embed\python.exe .\.pylibs\pip.pyz install --upgrade virtualenv
    .python-embed\python.exe .\.pylibs\pip.pyz install --upgrade pip
    ::.python-embed\python.exe .\.pylibs\pip.pyz install --upgrade virtualenv pip
    ::.python-embed\python.exe -m pip install --upgrade pip
  :download_init_2
  @if not exist .venv .python-embed\python.exe -m virtualenv .venv
  @call .venv\Scripts\activate
  @python --version
  @pip --require-virtualenv --version
  @python -m pip --require-virtualenv install --upgrade pip
  @pip --require-virtualenv --version
  @set PIP_EXE=pip3 --require-virtualenv
  @set VIRTUAL
@goto :eof

:download_cmd
  @echo Download for %* ...
  ::@set PIP_OPTS=--no-cache-dir --extra-index-url https://download.pytorch.org/whl/cu118
  @set PIP_OPTS= --exists-action i
  @%PIP_EXE% download -qqq --log .\.log\%RANDOM%%RANDOM%%RANDOM%.log %PIP_OPTS% -d .\.pylibs %*
  @if %ERRORLEVEL% neq 0 (echo PIP_ERROR:%ERRORLEVEL% & exit /b %ERRORLEVEL%)
  :: @%PIP_EXE% download -vvv %PIP_OPTS% --log %~nx0.%RANDOM%.log -d .\.pylibs %* 2>&1 >nul 
@goto :eof

:download_item
  @set param=%1
  @if exist "%param%" (
    for /F "usebackq" %%I in (`dir /S /B /A-D "%param%" ^|sort`) do call :download_cmd -r %%I
  ) else (
    call :download_cmd "%param%"
  )
@goto :eof

:main
  @set param=%~1
  @if "" == "%param%"       (call :print_help_and_exit & exit 1)
  @if "%param%" == "--help" (call :print_help_and_exit & exit 1)
  @if "%param%" == "--init" (call :download_init & exit 0)
  @call :download_init
  @for %%I in ( %* ) do call :download_item %%I
  ::.\make_links_log.sh
@goto :eof

