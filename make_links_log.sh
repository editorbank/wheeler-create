index_tmp=make_links_log.index.tmp

found_link_for(){
  grep -m1 $1 $index_tmp
}

make_links_log(){
  local outfile=./.pylibs/links.log
  echo Make $outfile ...
  find .log -name '*.log' -type f | grep -E '.+' || (echo "Not Found '.log/*.log'!" ; return 1)
  echo Make index file $index_tmp ...
  grep -h -o -E 'Found link [^ #]+' .log/*.log | cut -d" " -f3 | sort -u >$index_tmp
  [ ! -f $outfile ] || rm $outfile
  echo Scan file of .pylibs ...
  files=$(ls -1 ./.pylibs | sort --ignore-case)
  for f in $files; do
    echo -n "."
    found_link_for $f >>$outfile
  done
  echo -e ""
  [ ! -f $index_tmp ] || rm $index_tmp
}

make_links_log $@ && echo "$(basename $0) - OK" || echo "$(basename $0) - FAIL"
