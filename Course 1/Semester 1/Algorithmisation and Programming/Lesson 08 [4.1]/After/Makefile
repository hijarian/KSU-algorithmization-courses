FPCDIR=/usr/lib/fpc/2.6.0/units/x86_64-linux
TESTSCFG=-Fu"../../FPTest/" -Fu"$(FPCDIR)/fcl-base" -Mobjfpc
LESSONIDX=08

all: tests lesson clean

tests:
	fpc $(TESTSCFG) Tests$(LESSONIDX).pas
lesson:
	fpc Lesson$(LESSONIDX).pas

clean:
	rm *.o *.ppu

