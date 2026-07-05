.PHONY: build insall uninstall pam pam-force

install_path = /usr/local/bin/i3lock
pam_dst = /etc/pam.d/i3lock

build:
	rm -rf build/
	mkdir -p build
	cd build/ && \
	meson setup -Dprefix=/usr && \
	ninja
	mv build/i3lock .
	$(MAKE) pam

install: build
	chmod +x i3lock
	sudo mv i3lock $(install_path)

uninstall:
	sudo rm -f $(install_path)
	sudo rm -f $(pam_dst)

pam:
	@if [ -f /etc/pam.d/i3lock ]; then \
		echo "Pam already exists"; \
	else \
		$(MAKE) pam-force; \
	fi

pam-force:
	sudo cp pam/i3lock $(pam_dst)
