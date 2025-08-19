set -e
export WHEELER_DIR="${WHEELER_DIR:-$(realpath .pylibs)}"
this_dir=$PWD
test_list=$(find tests -maxdepth 2 -type f -name requirements.txt )
for i in $test_list ; do
  echo --- $i ...
  cd $(dirname $this_dir/$i)
  if [ -x ./test.sh ] ; then
    . ./test.sh
  else
    . ../../ve.sh
    pytest
  fi
  if [ -x ./clean.sh ] ; then
     . ./clean.sh
  fi
  echo --- $i - OK
done
echo --- $0 - OK

