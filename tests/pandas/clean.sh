cd "$(realpath -m $0/..)"

func1() {
  while read line; do
    find . -name "$line" -type d -exec rm -rf {} \;
  done < "${1:-/dev/stdin}"
}

[ -f .gitignore ] && sed -E 's/^[\s]*#.*$//' .gitignore | func1
