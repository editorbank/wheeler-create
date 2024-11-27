set docker_image=docker.io/editorbank/wheeler:1.3.2

for /F "usebackq" %%I in ( `docker images -q --filter=reference=%docker_image%` ) do set id_image=%%I
if defined id_image (
  echo Image %docker_image% already builded id="%id_image%"!
) else (
  docker build . -t %docker_image% --build-arg DEFAULT_WHEELER_PORT=8080
)
