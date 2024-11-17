cd $(realpath -m $0/..) && (
declare -a tmp_dir=(".meltano" "plugins" ".venv")
for i in  ${tmp_dir[@]} ;do
  [ -d "$i" ] && ( echo Remove dir "$PWD/$i" ...; rm -rf "$PWD/$i" ) || ( echo Dir "$PWD/$i" already removed.)
done
) && echo OK
