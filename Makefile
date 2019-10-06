default:
	cd Source && $(MAKE) && mv driver ../driver

clean:
	cd Source && $(MAKE) clean
