echo "ref: "
read ref
echo "lenke: "
python3 -c'import tiny; tiny.tinyurl('\"$url\"','\"$ref\"')'
