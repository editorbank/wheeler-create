FROM ubuntu/python:3.10-22.04_stable
COPY ./.pylibs /pylibs

EXPOSE 8080
CMD ["exec", "python3", "-m", "http.server", "-d", "/pylibs", "8080"]
