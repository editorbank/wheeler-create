#!/bin/env bash

PIP_EXE="python3 ./.pylibs/pip.pyz"
PYTHON_VERSION="3.10.10"
PTH_NAME="python310"

set -e

print_help_and_exit(){
  echo -e "\
Use: $(basename $0) <libname|requirement_file|folder_with_requirement_files>\n\
For example:
  $0 ./requirements\n\
  $0 ./requirements/a1.requirements.txt\n\
  $0 numpy\n\
  $0 numpy==1.24.3\n\
"
  exit 1;
}

download_direct(){
  if [ ! -f ./.pylibs/$1 ] ;then 
    echo Download $2 to $1 ...
    echo Found link $2 >>.log/$0.log
    curl -ks --fail -o ./.pylibs/$1 $2||exit 1
  fi
}

download_init(){
  if [ ! -d ./.log ] ; then mkdir ./.log ; fi
  if [ ! -d ./.pylibs ] ; then mkdir ./.pylibs ; fi
  #download_direct pip.pyz https://bootstrap.pypa.io/pip/pip.pyz
  
  #download_direct python-$PYTHON_VERSION-embed-win_amd64.zip https://www.python.org/ftp/python/$PYTHON_VERSION/python-$PYTHON_VERSION-embed-amd64.zip
  if [ ! -d .venv ] ;then  python3 -m venv .venv ; fi
  if [ ! -f .venv/bin/activate ] ;then echo "Error create .venv!" ; exit 1 ; fi
  source .venv/bin/activate
  if [ ! -n "$VIRTUAL_ENV" ] ;then echo "Error activate virtual environment!" ; exit 1 ; fi

  if [ ! -f "$VIRTUAL_ENV/pip_upgrade.tmp" ] ;then
    python -m pip install --upgrade pip && pip --version >"$VIRTUAL_ENV/pip_upgrade.tmp"
  fi

  python --version
  pip --require-virtualenv --version
  export PIP_EXE="pip --require-virtualenv"
}

download_cmd(){
  echo Download for $@ ...
  #local PIP_OPTS="--no-cache-dir --extra-index-url https://download.pytorch.org/whl/cu118"
  local PIP_OPTS=" --exists-action i"
  $PIP_EXE download -qqq $PIP_OPTS -d ./.pylibs --log .log/$RANDOM$RANDOM$RANDOM.log $@
}

download_item(){
  local param="$1"
  if [ -d "$param" ] ;then 
    local declare requirement_list=$(find "$param" -iname "*requirements.txt"|sort)
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
  # . ./make_links_log.sh
}

main $@ && echo $0 - OK || echo $0 - FAIL
