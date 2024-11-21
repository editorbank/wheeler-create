set py_embed=..\..\.python-embed\python.exe
set venv_dir=%CD%\.venv
set venv_act=%venv_dir%\Scripts\activate.bat
if not defined WHELLER_DIR for %%I in ( ..\..\.pylibs ) do if exist "%%~dpnxI" set WHELLER_DIR=%%~dpnxI

if not defined WHELLER_DIR (1>&2 echo ERROR: Not defined or not exist WHELLER_DIR! & exit 1)
if not exist "%py_embed%"  (1>&2 echo ERROR: Not exists "%py_embed%"! & exit 1)
set PYTHONHOME=
set PYTHONPATH=
if not exist "%venv_dir%" call  %py_embed% -m virtualenv "%venv_dir%"
if exist "%venv_act%" call "%venv_act%"
if not defined VIRTUAL_ENV (1>&2 echo ERROR: Not activate VIRTUAL_ENV! & exit 1)
set PIP_CONFIG_FILE="%VIRTUAL_ENV%\pip.ini"
if not exist "%PIP_CONFIG_FILE%" (
  echo.[global]
  echo.no-index=true
  echo.find-links=%WHELLER_DIR%
) >"%PIP_CONFIG_FILE%"


if not exist "%VIRTUAL_ENV%\pip.log" python -m pip install --upgrade pip --log "%VIRTUAL_ENV%\pip.log"
if exist requirements.txt if not exist "%VIRTUAL_ENV%\requirements.log" pip install -r requirements.txt --log "%VIRTUAL_ENV%\requirements.log"
