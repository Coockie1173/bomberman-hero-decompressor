CC = gcc
CFLAGS = -Wall -g
SRCDIR = src
BUILDDIR = build

ifeq ($(OS),Windows_NT)
	EXE_EXT = .exe
else
	EXE_EXT =
endif

SRCFILES := $(wildcard $(SRCDIR)/*.c)
OBJFILES := $(patsubst $(SRCDIR)/%.c, $(BUILDDIR)/%.o, $(SRCFILES))

all: $(BUILDDIR) myprogram$(EXE_EXT)

$(BUILDDIR)/%.o: $(SRCDIR)/%.c | $(BUILDDIR)
	$(CC) $(CFLAGS) -c $< -o $@

myprogram$(EXE_EXT): $(OBJFILES)
	$(CC) $(CFLAGS) $(OBJFILES) -o $(BUILDDIR)/myprogram$(EXE_EXT)

$(BUILDDIR):
	mkdir $(BUILDDIR)

clean:
	rm -rf $(BUILDDIR) extracted

.PHONY: clean

extract: $(BUILDDIR) myprogram$(EXE_EXT)
	rm -rf extracted
	mkdir extracted
	./$(BUILDDIR)/myprogram$(EXE_EXT) ./Hero.z64 ./extracted

.PHONY: extract
