echo "Lenke: "
read url
echo "ref: "
read ref
python3 -c'import tiny; tiny.tinyurl('\"$url\"','\"$ref\"')'
