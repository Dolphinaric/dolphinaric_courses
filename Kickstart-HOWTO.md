#How to make your own kickstart files#

##Introduction##

###What are Kickstart installations?###
Kickstart files are used to automatically install the OS into a machine. In our case it is the preferred way of installing the OS into an embedded device. They contain specific instructions about the configuration files, the packages to be installed, etc. After creating the kickstart file you can use mic image creator to produce the final system image.

##Sample Kickstart file (for Raspberry Pi)##
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


1. lang
This required command sets the language to use during installation and the default language to use on the installed system to <id>. This can be the same as any recognized setting for the $LANG environment variable, though not all languages are supported during installation.
lang <id>

2. keyboard
This required command sets system keyboard type.
keyboard [arg]

3. timezone
This required command sets the system time zone to <timezone> which may be any of the time zones listed by timeconfig. 
timezone [--utc] <timezone> 

4. part or partition 
Creates a partition on the system. This command is required. 
part <mntpoint>
The <mntpoint> is where the partition will be mounted and must be of one of the following forms:
    /<path> 
        For example, /, /usr, /home 
    swap 
        The partition will be used as swap space. 
    raid.<id> 
        The partition will be used for software RAID (refer to raid). 
    pv.<id> 
        The partition will be used for LVM (refer to logvol). 
--size=
    The minimum partition size in megabytes. Specify an integer value here such as 500. Do not append the number with MB. 
--ondisk= or --ondrive=
    Forces the partition to be created on a particular disk.
--fstype=
    Sets the file system type for the partition. Valid values include ext4, ext3, ext2, btrfs, swap, and vfat. 

5. rootpw
This required command sets the system's root password to the <password> argument. 
rootpw <password>

6. user
Creates a new user on the system. 
--name=
    Provides the name of the user. This option is required.
--groups=
    In addition to the default group, a comma separated list of group names the user should belong to.  
--password=
    The new user's password. If not provided, the account will be locked by default.

7. repo
Configures additional yum repositories that may be used as sources for package installation. Multiple repo lines may be specified.
repo --name=<name> [--baseurl=<url>|--mirrorlist=<url>] [options] 
--name=
    The repo id. This option is required. If a repo has a name that conflicts with a previously added one, the new repo will be ignored. 
--baseurl=
    The URL for the repository. The variables that may be used in yum repo config files are not supported here. You may use one of either this option or --mirrorlist, not both. If an NFS repository is specified, it should be of the form nfs://host:/path/to/repo.

##Chapter 3. Package  Selection##
Use the %packages command to begin a kickstart file section that lists the packages you would like to install.
Packages can be specified by group or by individual package name. The installation program defines several groups that contain related packages.In most cases, it is only necessary to list the desired groups and not individual packages.

Groups are specified, one to a line, starting with an @ symbol followed by the full group name or by using the group id. Specify individual packages with no additional characters.

Again there many other tricks and options you can use. Check it [here](https://fedoraproject.org/wiki/Anaconda/Kickstart).


##Chapter 4. Post-Installation Script##
You have the option of adding commands to run on the system once the installation is complete. This section must be at the end of the kickstart file and must start with the %post command. This section is useful for functions such as installing additional software and configuring an additional nameserver.
You may have more than one %post section, which can be useful for cases where some post-installation scripts need to be run in the chroot and others that need access outside the chroot.
Each %post section is required to be closed with a corresponding %end. 

--nochroot 
    Allows you to specify commands that you would like to run outside of the chroot environment. 



