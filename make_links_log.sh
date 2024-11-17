found_link_for(){
  grep $1 .log/*.log | grep -o -E 'Found link [^ #]+' | tail -1 | cut -d" " -f3 
}

make_links_log(){
  local outfile=./.pylibs/links.log
  echo Make $outfile ...
  find .log -name '*.log' -type f | grep -E '.+' || (echo "Not Found '.log/*.log'!" ; return 1)
  [ ! -f $outfile ] || rm $outfile
  files=$(ls -1 ./.pylibs | sort --ignore-case)
  for f in $files; do
    echo -n "."
    found_link_for $f >>$outfile
  done
  echo -e ""
}

make_links_log $@ && echo "$(basename $0) - OK" || echo "$(basename $0) - FAIL"
