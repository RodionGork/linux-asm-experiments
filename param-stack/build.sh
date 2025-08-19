rm -f test
as --32 test.s
if [[ $? -eq "0" ]] ; then
  ld -m elf_i386 -o test a.out
fi
rm -f a.out
