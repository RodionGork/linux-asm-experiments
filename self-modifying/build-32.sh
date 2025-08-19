rm -f self-mod-32
as --32 self-mod-32.s
if [[ $? -eq "0" ]] ; then
  ld -m elf_i386 -o self-mod-32 a.out
fi
rm -f a.out
