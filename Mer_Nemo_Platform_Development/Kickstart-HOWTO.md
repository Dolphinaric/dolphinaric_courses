#How to make your own kickstart files#

##Introduction##

###What are Kickstart installations?###
Kickstart files are used to automatically install the OS into a machine. In our case it is the preferred way of installing the OS into an embedded device. They contain specific instructions about the configuration files, the packages to be installed and the actions to be performed before or after installation.

###How can I use the kickstart file###
After creating the kickstart file you can use mic image creator to produce the final system image.

##Sample Kickstart file source code(for Raspberry Pi)##
	#
	# Kickstart for Raspberry Pi
	#

	lang en_US.UTF-8
	keyboard us
	timezone --utc UTC
	part /boot --size 50 --ondisk mmcblk0p --fstype=vfat
	part / --size 1500 --ondisk mmcblk0p --fstype=ext4
	rootpw rootme 

	user --name mer  --groups audio,video --password rootme 

	repo --name=mer-core --baseurl=http://releases.merproject.org/releases/latest/builds/armv6l/packages --save --debuginfo --source
	repo --name=mer-tools --baseurl=http://repo.merproject.org/obs/mer-tools:/stable/latest_armv6l/ --save --debuginfo --source
	repo --name=rpi-ha --baseurl=http://repo.merproject.org/obs/nemo:/devel:/hw:/brcm:/bcm2835:/rpi/latest_armv6l/ --save --debuginfo --source
	repo --name=nemo-mw --baseurl=http://repo.merproject.org/obs/nemo:/stable:/mw/latest_armv6l/ --save --debuginfo --source

	repo --name=rpi-ha_mod --baseurl=http://repo.merproject.org/obs/home:/JvD:/branches:/nemo:/devel:/hw:/brcm:/bcm2835:/rpi/latest_armv6l/ --save --debuginfo --source

	%packages

	@Mer Connectivity
	@Mer Graphics Common
	@Mer Minimal Xorg
	@Mer Core

	#@Raspberry Pi Boot
	bootloader-rpi
	kernel-adaptation-rpi

	#@Raspberry Pi GFX
	gfx-rpi
	gfx-rpi-libOMXIL
	gfx-rpi-libEGL
	gfx-rpi-libGLESv1
	gfx-rpi-libGLESv2


	qt-qmlviewer
	xorg-x11-drv-evdev
	xorg-x11-drv-vesa
	xorg-x11-drv-fbdev
	xorg-x11-server-Xorg-setuid
	-xorg-x11-server-Xorg

	openssh
	openssh-clients
	openssh-server
	
	%end

	%post
	# Without this line the rpm don't get the architecture right.
	echo -n 'armv6l-meego-linux' > /etc/rpm/platform
	
	# Also libzypp has problems in autodetecting the architecture so we force tha as well.
	# https://bugs.meego.com/show_bug.cgi?id=11484
	echo 'arch = armv6l' >> /etc/zypp/zypp.conf

	# Create a session file for qmlviewer.
	cat > /usr/share/xsessions/X-MER-QMLVIEWER.desktop << EOF
	[Desktop Entry]
	Version=1.0
	Name=qmlviewer
	Exec=/usr/bin/qmlviewer
	Type=Application
	EOF

	# Set symlink pointing to .desktop file 
	ln -sf X-MER-QMLVIEWER.desktop /usr/share/xsessions/default.desktop

	# Rebuild db using target's rpm
	echo -n "Rebuilding db using target rpm.."
	rm -f /var/lib/rpm/__db*
	rpm --rebuilddb
	echo "done"

	# Prelink can reduce boot time
	if [ -x /usr/sbin/prelink ]; then
	   echo -n "Running prelink.."
	   /usr/sbin/prelink -aRqm
	   echo "done"
	fi


	%end

	%post --nochroot

	%end

##Sample Kickstart file walkthrough##
Code:

	#
	# Kickstart for Raspberry Pi
	#

Explanation:
Lines beginning with the symbol (#) are treated as comments and therefore are ignored.

Code:

	lang en_US.UTF-8

Explanation:
lang command is used to set the language to use during installation and the default language to use on the installed system.

Code:

	keyboard us
	
Explanation:
keyboard command is used to set the system keyboard type.

Code:

	timezone --utc UTC
	
Explanation:
timezone command is used to set the system timezone. If the --utc option is present the system assumes the hardware clock is set to UTC time.

Code:

	part /boot --size 50 --ondisk mmcblk0p --fstype=vfat
	part / --size 1500 --ondisk mmcblk0p --fstype=ext4
	
Explanation:
part command is used to create a partition. It takes one argument: the mount point where the partition will be mounted.
* --size: sets the size of partition in MB.
* --ondisk: forces the partition to be created on a particular disk.
* --fstype: sets the filesystem type of the partition.

Code:

	rootpw rootme
	
Explanation:
rootpw sets the password for the root account.

Code:

	user --name mer  --groups audio,video --password rootme
	
Explanation:
user command creates a new user. 
* --name: sets the username.
* --group: specifies the groups where this user should belong besides the default one.
* --password: sets the user's password.

Code:

	repo --name=mer-core --baseurl=http://releases.merproject.org/releases/latest/builds/armv6l/packages --save --debuginfo --source
	repo --name=mer-tools --baseurl=http://repo.merproject.org/obs/mer-tools:/stable/latest_armv6l/ --save --debuginfo --source
	repo --name=rpi-ha --baseurl=http://repo.merproject.org/obs/nemo:/devel:/hw:/brcm:/bcm2835:/rpi/latest_armv6l/ --save --debuginfo --source
	repo --name=nemo-mw --baseurl=http://repo.merproject.org/obs/nemo:/stable:/mw/latest_armv6l/ --save --debuginfo --source

	repo --name=rpi-ha_mod --baseurl=http://repo.merproject.org/obs/home:/JvD:/branches:/nemo:/devel:/hw:/brcm:/bcm2835:/rpi/latest_armv6l/ --save --debuginfo --source
	
Explanation:
repo command configures additional repositories that may be used for package installation.
* --name: sets the id of the repository. This option is required.
* --baseurl: sets the URL for the repository.
* --save: saves the repository in /etc/zypp/repos.d.
* --debuginfo: adds the debuginfo repository.
* --source: ??

Code:

	%packages
	
Explanation:
%packages command begins a section that lists the packages to be installed. It must end with %end.

	@Mer Connectivity
	@Mer Graphics Common
	@Mer Minimal Xorg
	@Mer Core 

Lines starting with the @ sign specify a whole group of packages to be installed in a single line. Package group should be declared by its full name.

	bootloader-rpi
	kernel-adaptation-rpi

	gfx-rpi
	gfx-rpi-libOMXIL
	gfx-rpi-libEGL
	gfx-rpi-libGLESv1
	gfx-rpi-libGLESv2


	qt-qmlviewer
	xorg-x11-drv-evdev
	xorg-x11-drv-vesa
	xorg-x11-drv-fbdev
	xorg-x11-server-Xorg-setuid
	-xorg-x11-server-Xorg

	openssh
	openssh-clients
	openssh-server

Lines which don't start with the @ sign specify a single package to be installed. In this particular example, the first two install the bootloader, the next two groups install the graphical interface and some graphic accelerators and the last three install ssh service.

Code:

	%post [--nochroot]
	
Explanation:
%post starts a section where you can add commands to run after the installation of the system. This section must be at the end of the kickstart file and is required to end with %end.

	\# Without this line the rpm don't get the architecture right.
	echo -n 'armv6l-meego-linux' > /etc/rpm/platform
	
	\# Also libzypp has problems in autodetecting the architecture so we force tha as well.
	\# https://bugs.meego.com/show_bug.cgi?id=11484
	echo 'arch = armv6l' >> /etc/zypp/zypp.conf

	\# Create a session file for qmlviewer.
	cat > /usr/share/xsessions/X-MER-QMLVIEWER.desktop << EOF
	[Desktop Entry]
	Version=1.0
	Name=qmlviewer
	Exec=/usr/bin/qmlviewer
	Type=Application
	EOF

	\# Set symlink pointing to .desktop file 
	ln -sf X-MER-QMLVIEWER.desktop /usr/share/xsessions/default.desktop

	\# Rebuild db using target's rpm
	echo -n "Rebuilding db using target rpm.."
	rm -f /var/lib/rpm/__db*
	rpm --rebuilddb
	echo "done"

	\# Prelink can reduce boot time
	if [ -x /usr/sbin/prelink ]; then
	   echo -n "Running prelink.."
	   /usr/sbin/prelink -aRqm
	   echo "done"
	fi

The above section is already well commented.

* --nochroot: allows you to specify commands that you would like to run outside the chroot environment.

This guide is based on the official Fedora project guide. You can find the whole documentation (as well as more details for what was described in this guide) [here](https://fedoraproject.org/wiki/Anaconda/Kickstart)
 
