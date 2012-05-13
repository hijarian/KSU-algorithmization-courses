FPCDIR=/usr/lib/fpc/2.6.0/units/x86_64-linux
TESTSCFG=-Fu"../../FPTest/" -Fu"$(FPCDIR)/fcl-base" -Mobjfpc

all: tests lesson clean

tests:
	fpc $(TESTSCFG) Tests01.pas
lesson:
	fpc Lesson01.pas

clean:
	rm *.o *.ppu fptest.ini

