#!/bin/env bash

PIP_EXE="python3 ./.pylibs/pip.pyz"
PYTHON_VERSION="3.10.10"
PTH_NAME="python310"

set -e

print_help_and_exit(){
  echo -e "\
Use: $(basename $0) <libname|requirement_file|folder_with_requirement_files>\n\
For example:
  $0 ./requirement\n\
  $0 ./requirement/a1.requirement.txt\n\
  $0 numpy\n\
  $0 numpy==1.24.3\n\
"
  exit 1;
}

download_direct(){
  if [ ! -f ./.pylibs/$1 ] ;then 
    echo Download $2 to $1 ...
    echo Found link $2 >>$0.log
    curl -ks --fail -o ./.pylibs/$1 $2||exit 1
  fi
}

download_init(){
  if [ ! -d ./.pylibs ] ;then mkdir ./.pylibs;fi
  download_direct pip.pyz https://bootstrap.pypa.io/pip/pip.pyz
  
  if [ "$OS" == "Windows_NT" ] ;then 
    download_direct python-$PYTHON_VERSION-embed-win_amd64.zip https://www.python.org/ftp/python/$PYTHON_VERSION/python-$PYTHON_VERSION-embed-amd64.zip
    if [ ! -d .python-embed ] ;then
      powershell -Command "Expand-Archive ./.pylibs/python-$PYTHON_VERSION-embed-win_amd64.zip -DestinationPath .python-embed"
      if [ ! -f .python-embed/$PTH_NAME._pth.bak ] ;then
        mv .python-embed/$PTH_NAME._pth .python-embed/$PTH_NAME._pth.bak
        echo Lib/site-packages>.python-embed/$PTH_NAME._pth
        cat .python-embed/$PTH_NAME._pth.bak>>.python-embed/$PTH_NAME._pth
      fi
      .python-embed/python.exe ./.pylibs/pip.pyz install --upgrade virtualenv pip
      #.python-embed/python.exe -m pip install --upgrade pip
    fi
    if [ ! -d .venv ] ;then
      #export PYTHONPATH=.python-embed/Lib/site-packages
      .python-embed/python.exe -m virtualenv .venv
    fi
    source .venv/Scripts/activate
    python --version
    pip3 --require-virtualenv --version
    export PIP_EXE="pip3 --require-virtualenv"
  fi

  
}

download_cmd(){
  echo Download for $@ ...
  local PIP_OPTS="--no-cache-dir --extra-index-url https://download.pytorch.org/whl/cu118"
  $PIP_EXE download -vvv $PIP_OPTS -d ./.pylibs $@ 2>&1 >>$0.log
  # $PIP_EXE download -vvv $PIP_OPTS --log $0.$RANDOM.log -d ./.pylibs $@ 2>&1 >/dev/null 
}

download_item(){
  local param="$1"
  if [ -d "$param" ] ;then 
    local declare requirement_list=$(find "$param" -iname "*requirement.txt"|sort)
    for requirement_file in $requirement_list; do
      download_cmd -r $requirement_file
    done
  else
    if [ -f "$param" ] ;then 
      download_cmd -r "$param"
    else
      download_cmd $param
    fi
  fi
}

main(){
  local param="$1"
  if [ -z "$param" -o "$param" == "--help" ] ;then print_help_and_exit; fi
  if [ "$param" == "--init" ] ;then download_init; exit 0; fi
  download_init
  for param in $@; do
    download_item $param
  done
  ./make_links_log.sh
}

main $@ && echo $0 - OK || echo $0 - FAIL
