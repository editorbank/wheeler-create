cd "$(realpath -m $0/..)"
. ../../ve.sh

meltano lock --update --all
meltano install
meltano test
cat meltano.yml | yq '.plugins[][].name' | xargs -i -tn1 meltano invoke {} --help >/dev/null
echo OK
