::set py_embed=..\..\.python-embed\python.exe
@set py_embed=..\..\.python.win\python.exe
@set venv_dir=%CD%\.venv
@set venv_act=%venv_dir%\Scripts\activate.bat

::if not defined WHEELER_DIR 
::for %%I in ( ..\..\.pylibs ) do set WHEELER_DIR=%%~dpnxI
::@set WHEELER_DIR=http://localhost:8000

@if not defined WHEELER_DIR (1>&2 echo ERROR: Not defined WHEELER_DIR! & exit /b 1)
::if not exist "%WHEELER_DIR%" (1>&2 echo ERROR: Not exists "%WHEELER_DIR%"! & exit /b 1)
::set WHEELER_DIR=%WHEELER_DIR:\=\\%
::set WHEELER_DIR=../../.pylibs
::set WHEELER_DIR=/Users/ed/work/wheeler-create.oneimage/.pylibs
::if not exist "%WHEELER_DIR%" (1>&2 echo ERROR: Not exists "%WHEELER_DIR%"! & exit /b 1)

@set PYTHONHOME=
@set PYTHONPATH=

@if not exist "%py_embed%"  (1>&2 echo ERROR: Not exists "%py_embed%"! & exit /b 1)
::if not exist "%venv_dir%" call  %py_embed% -m virtualenv "%venv_dir%"
@if not exist "%venv_dir%" %py_embed% -m venv "%venv_dir%"
@if exist "%venv_act%" call "%venv_act%" && echo on
@if not defined VIRTUAL_ENV (1>&2 echo ERROR: Not activate VIRTUAL_ENV! & exit /b 1)
::set PIP_OPTS=--timeout 5 --retries 1 --no-index --disable-pip-version-check --trusted-host localhost --find-links http://localhost:8000
::set PIP_OPTS=--timeout 5 --retries 1 --no-index --disable-pip-version-check --trusted-host localhost --find-links %WHEELER_DIR%
::if not exist "%PIP_CONFIG_FILE%" 
@set PIP_CONFIG_FILE=%VIRTUAL_ENV%\pip.ini
@(
  echo.[global]
  echo.timeout = 5
  echo.retries = 1
  echo.require-virtualenv = true
  echo.disable-pip-version-check = true
  echo.
  echo.trusted-host = localhost
  echo.no-index = true
  echo.find-links = %WHEELER_DIR%
) >"%PIP_CONFIG_FILE%"
@echo PYTHONHOME=%PYTHONHOME%
@echo PYTHONPATH=%PYTHONPATH%
@echo PIP_CONFIG_FILE=%PIP_CONFIG_FILE%
@if exist "%PIP_CONFIG_FILE%" @type "%PIP_CONFIG_FILE%"

if not exist "%VIRTUAL_ENV%\pip.log" python -m pip install --upgrade pip --log "%VIRTUAL_ENV%\pip.log"
if exist requirements.txt if not exist "%VIRTUAL_ENV%\requirements.log" pip install -r requirements.txt --log "%VIRTUAL_ENV%\requirements.log"
