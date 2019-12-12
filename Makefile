default:
	cd Source && $(MAKE) && mv driver ../driver

clean:
	-rm -f driver
	-rm -f Output.asm
	-rm -f Output
	cd Source && $(MAKE) clean
