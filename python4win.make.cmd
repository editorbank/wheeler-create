@call python4win.config.cmd

@set pyinst_exe=%CD%\.python_tmp_installer.exe
@set pyinst_dir=%CD%\.python_tmp_installed
@set pyinst_arch=%CD%\.pylibs\%pyinst_id%.zip

@if not exist "%pyinst_exe%" curl -o "%pyinst_exe%" "%pyinst_url%"
@if not exist "%pyinst_exe%" (1>&2 echo Not download "%pyinst_url%"! & exit /b 1)

@if not exist "%pyinst_dir%" %pyinst_exe% /passive /log %~n0.inst.log InstallAllUsers=0 TargetDir="%pyinst_dir%" ^
AssociateFiles=0 Shortcuts=0 Include_doc=0 Include_dev=0 ^
Include_exe=0 Include_launcher=0 InstallLauncherAllUsers=0 ^
Include_lib=1 Include_pip=1 Include_tcltk=0 Include_test=0 Include_tools=0

@if not "%ERRORLEVEL%"=="0" (1>&2 echo Not installed "%pyinst_exe%"! & exit /b 1)

@if not exist "%pyinst_dir%" (1>&2 echo Not exist dir "%pyinst_dir%"! & exit /b 1)
@pushd "%pyinst_dir%"
  @echo %pyinst_url%>download.txt
  @echo Delete *.pyc in %CD% ...
  @del /S /Q *.pyc
  @for %%I in ( "%pyinst_arch%" ) do @if not exist "%%~dpI" md "%%~dpI" 
  @echo Create Archive "%pyinst_arch%" ...
  @powershell -Command "Compress-Archive -Path .\* -DestinationPath %pyinst_arch% -Force"
  @if not "%ERRORLEVEL%"=="0" (1>&2 echo Not create archive "%pyinst_arch%"! & exit /b 1)
  @del download.txt
@popd


@echo Uninstall "%pyinst_dir%" ...
@%pyinst_exe% /uninstall /passive /log %~n0.uninst.log
@if not "%ERRORLEVEL%"=="0" (1>&2 echo Not uninstall from "%pyinst_dir%"! & exit /b 1)

@echo Delete tem files ...
@if exist "%~n0.*.log" del /S /Q "%~n0.*.log"
@if exist "%pyinst_exe%" del /Q "%pyinst_exe%"
@echo %~n0 - OK