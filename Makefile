
default: install

install: fix_permissions
	pkg install -y expect openvpn
	pkg update
	pkg fetch -u -y
	pkg upgrade -y
	cp ./scripts/rc.d.sh /etc/rc.d/transmissionvpn
	cp /etc/rc.conf ./rc.conf.backup
	@clear
	@echo "In the FreeNAS web interface, please enable and then disable the Transmission plugin (from the Plugins > Installed page)."
	@echo "Press [ENTER] once the plugin is disabled." ; \
		read userdone
	if [ "`cat /etc/rc.conf | grep "transmissionvpn_enable" | wc -l`" -lt "1" ] ; then echo "transmissionvpn_enable=\"YES\"" >> /etc/rc.conf ; fi
	cat /etc/rc.conf | grep -v "transmission_enable" > rc.conf.tmp
	cat rc.conf.tmp > /etc/rc.conf
	rm rc.conf.tmp
	echo "transmission_enable=\"YES\"" >> /etc/rc.conf
	/usr/local/etc/rc.d/transmission start
	sleep 3  # Sometimes, the following stop happens before the process can completely start.
	/usr/local/etc/rc.d/transmission stop
	@clear
	@echo "Enter your OpenVPN username and press [ENTER]:" ; \
		read username ; \
		echo "Enter your OpenVPN password and press [ENTER]:" ; \
		read password ; \
		sed s/USERNAME/$$username/ run.sh.template | sed s/PASSWORD/$$password/ > run.sh
	chmod +x run.sh
	@clear
	@echo -e "\nUsername and password written to the OpenVPN running script, run.sh."
	@echo -e "PLEASE BE AWARE:  These are written out in plain text.\n\n"
	@echo "Configuration complete.  OpenVPN has been installed.  It will automatically connect on boot and start Transmision."
	@echo "You will still need to download your provider's openvpn.conf and associated keys."
	@echo "Place openvpn.conf and the keys into ./openvpn.  One this is done, you can launch OpenVPN and Transmission by running:"
	@echo -e "\n     /etc/rc.d/transmissionvpn start\n\nTo stop Transmission and OpenVPN, run:\n\n     /etc/rc.d/transmissionvpn stop\n\n"
	@echo "Enjoy!"

fix_permissions:
	chmod +x *.sh
	chmod +x scripts/*.sh

optional: 
	pkg install -y bash nano vim
	pkg update
	pkg fetch -u -y
	pkg upgrade -y
	pkg_add -r git
