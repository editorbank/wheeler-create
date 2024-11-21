set py_embed=..\..\.python-embed\python.exe
set venv_dir=%CD%\.venv
set venv_act=%venv_dir%\Scripts\activate.bat

::if not defined WHEELER_DIR 
for %%I in ( ..\..\.pylibs ) do set WHEELER_DIR=%%~dpnxI
if not defined WHEELER_DIR (1>&2 echo ERROR: Not defined WHEELER_DIR! & exit /b 1)
if not exist "%WHEELER_DIR%" (1>&2 echo ERROR: Not exists "%WHEELER_DIR%"! & exit /b 1)
set WHEELER_DIR=%WHEELER_DIR:\=\\%
if not exist "%WHEELER_DIR%" (1>&2 echo ERROR: Not exists "%WHEELER_DIR%"! & exit /b 1)
pause
if not exist "%py_embed%"  (1>&2 echo ERROR: Not exists "%py_embed%"! & exit /b 1)
set PYTHONHOME=
set PYTHONPATH=
if not exist "%venv_dir%" call  %py_embed% -m virtualenv "%venv_dir%"
if exist "%venv_act%" call "%venv_act%"
if not defined VIRTUAL_ENV (1>&2 echo ERROR: Not activate VIRTUAL_ENV! & exit /b 1)
set PIP_CONFIG_FILE="%VIRTUAL_ENV%\pip.ini"
::if not exist "%PIP_CONFIG_FILE%" 
(
  echo.[global]
  echo.no-index=true
  echo.find-links=%WHEELER_DIR%
) >"%PIP_CONFIG_FILE%"


if not exist "%VIRTUAL_ENV%\pip.log" python -m pip install --upgrade pip --log "%VIRTUAL_ENV%\pip.log"
if exist requirements.txt if not exist "%VIRTUAL_ENV%\requirements.log" pip install -r requirements.txt --log "%VIRTUAL_ENV%\requirements.log"
