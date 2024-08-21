
_config=$1
if [ -z "${_config}" ];then _config="./project.ini";fi
if [ ! -f "${_config}" ];then echo "Error, not found ${_config}!"; exit 1;fi

config_value(){
  echo $(git config -f ${_config} --get $1)
}

export config_value

export docker=$(config_value docker.exe)
export docker_server=$(config_value docker.server)
export docker_imagepath=$(config_value docker.imagepath)
export docker_imagename=$(config_value docker.imagename)
export docker_imagetag=$(config_value docker.imagetag)

export docker_image=$docker_server/$docker_imagepath/$docker_imagename:$docker_imagetag
