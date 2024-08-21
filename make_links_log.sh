found_link_for(){
  #grep $1 ./download.sh*.log | grep -o -P 'Found link [^ ]+' | tail -1 | cut -d" " -f3 
  grep $1 ./download.sh*.log | grep -o -E 'Found link [^ #]+' | tail -1 | cut -d" " -f3 
}

make_links_log(){
  local outfile=./.pylibs/links.log
  echo Make $outfile ...
  find . -name 'download.*.log' | grep -E '.+' || (echo "Not Found'download.*.log'!" ; return 1)
  [ ! -f $outfile ] || rm $outfile
  files=$(ls -1 ./.pylibs | sort --ignore-case)
  for f in $files; do
    found_link_for $f >>$outfile
  done
}

make_links_log $@ && echo $0 - OK || echo $0 - FAIL
