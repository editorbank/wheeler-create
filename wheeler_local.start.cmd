@call python4win.activate.cmd
xcopy /E /Y /F  .\meltano_hub\* .\.pylibs\
start "%~n0" python -m http.server 8000 -d .\.pylibs\
