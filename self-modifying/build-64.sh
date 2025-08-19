rm -f self-mod-64
as self-mod-64.s
if [[ $? -eq "0" ]] ; then
  ld -o self-mod-64 a.out
fi
rm -f a.out
