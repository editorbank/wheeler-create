FROM ubuntu
RUN apt update && apt install -y python3 python3-pip python3.10-venv && apt clean

#ENTRYPOINT ["python3","-m","http.server","-d","/pylibs","8080"]
#EXPOSE 8080
