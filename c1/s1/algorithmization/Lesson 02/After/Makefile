FPCDIR=/usr/lib/fpc/2.6.0/units/x86_64-linux
FPTESTDIR=../../FPTest/
TESTSCFG=-Fu"$(FPTESTDIR)" -Fu"$(FPCDIR)/fcl-base" -Mobjfpc

LESSONIDX=02

all: tests lesson task clean

tests: Tests$(LESSONIDX).pas
	fpc $(TESTSCFG) Tests$(LESSONIDX).pas

lesson: Lesson$(LESSONIDX).pas
	fpc Lesson$(LESSONIDX).pas

task: Task$(LESSONIDX).tex
	pdflatex Task$(LESSONIDX).tex

clean:
	rm *.o *.ppu *.aux *.log

