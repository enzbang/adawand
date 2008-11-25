GNATMAKE = gnat make
CP      = cp -p

all::
	$(GNATMAKE) -Pmagickwand

regtests::
	$(GNATMAKE) -Pmagickwand_test
	$(CP) test/data/adapowered.jpg test/obj/
	cd test/obj && ./test
