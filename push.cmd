@set docker_image=docker.io/editorbank/wheeler:1.3.2

@for /F "usebackq" %%I in ( `docker images -q --filter=reference=%docker_image%` ) do @set id_image=%%I
@if defined id_image (
  docker login && docker push %docker_image%
)
