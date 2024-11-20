set -e
export WHELLER_DIR="${WHELLER_DIR:-$(realpath .pylibs)}"
this_dir=$PWD
test_list=$(find tests -maxdepth 2 -type f -name test.sh)
for i in $test_list ; do
  echo --- $i ...
  cd $(dirname $this_dir/$i)
  . test.sh && [ -x ./clean.sh ] && ./clean.sh
  echo --- $i - OK
done
echo --- $0 - OK

