@call python4win.config.cmd

@set pyinst_arch=%CD%\.pylibs\%pyinst_id%.zip
@set pyinst_dir=%CD%\.python.win
@set venv_dir=%CD%\.venv.win
@set venv_act=%venv_dir%\Scripts\activate.bat

@if not exist "%pyinst_arch%" (1>&2 echo Not exists "%pyinst_arch%"! & exit /b 1)
@if not exist "%pyinst_dir%" powershell -Command "Expand-Archive %pyinst_arch% -DestinationPath %pyinst_dir%"
@if not "%ERRORLEVEL%"=="0" (1>&2 echo Error expand "%pyinst_arch%"! & exit /b 1)
@if not exist "%pyinst_dir%\python.exe" (1>&2 echo Not exists "%pyinst_dir%\python.exe"! & exit /b 1)

@set PYTHONHOME=
@set PYTHONPATH=
@"%pyinst_dir%\python.exe" --version
@if not "%ERRORLEVEL%"=="0" (1>&2 echo Not get Python version! & exit /b 1)
@if not exist %venv_dir% "%pyinst_dir%\python.exe" -B -m venv %venv_dir%
@if not "%ERRORLEVEL%"=="0" (1>&2 echo Not create virtual environment! & exit /b 1)
@if not exist "%venv_act%" (1>&2 echo Not exists "%venv_act%"! & exit /b 1)
@call "%venv_act%" && echo on
pip --require-virtualenv --version
@if not "%ERRORLEVEL%"=="0" (1>&2 echo Not get PIP version! & exit /b 1)
@echo %~n0 - OK
