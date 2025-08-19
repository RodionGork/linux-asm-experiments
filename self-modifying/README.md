# Self-modifying programs

Very simple programs which just try to modify their code (.text section) -
this is restricted by default, so we call "mprotect" system function here.

Another option is to add `--omagic` switch to the linker call (ld), so the
proper flags are set on the sections in the generated elf-file. But this is
less "granular" of course and will prevent linking with dynamic libraries
(objcopy tool could be still used, but there are other subtleties).
