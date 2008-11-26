all::

GNATMAKE = gnat make
CP      = cp -p
MKDIR   = mkdir -p
BUILD_DIR         = .build/$(shell echo $(MODE) | tr [[:upper:]] [[:lower:]])

# Install prefix
GNAT_ROOT         = $(dir $(shell which gnatls))..
prefix	          =

ifeq (${OS},Windows_NT)
	LIBEXT = .dll
else
	LIBEXT = .so
endif

ifeq (,$(prefix))
	prefix = $(shell cat $(BUILD_DIR)/gnat.root 2>/dev/null)
endif

prepare_install:
	$(shell echo $(GNAT_ROOT) > $(BUILD_DIR)/gnat.root)

GPR =
GPR += magickwand

BLD_GPR := $(addprefix bld-, $(GPR))
CLN_GPR := $(addprefix cln-, $(GPR))
CHK_GPR := $(addprefix chk-, $(GPR))

$(BLD_GPR): bld-% :
	$(GNATMAKE) -P$*

$(CLN_GPR): cln-% :
	$(GNATCLEAN) -P$*

$(CHK_GPR): chk-% :
	$(GNATCHECK) -P$*

clean: $(CLN_GPR)

gnatcheck: $(CHK_GPR)

all:: mkdirs bld-magickwand prepare_install

mkdirs:
	$(MKDIR) $(BUILD_DIR)

regtests::
	$(GNATMAKE) -Pmagickwand_test
	$(CP) test/data/adapowered.jpg test/obj/
	cd test/obj && ./test

install::
	$(MKDIR) $(prefix)/lib/magickwand
	$(MKDIR) $(prefix)/include/magickwand
	$(MKDIR) $(prefix)/lib/gnat
	$(CP) lib/*ada_magick_wand$(LIBEXT) $(prefix)/lib/magickwand
	$(CP) src/*.ad[sb] $(prefix)/include/magickwand
	$(CP) distrib/magickwand.gpr $(prefix)/lib/gnat
