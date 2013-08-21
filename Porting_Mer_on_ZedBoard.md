#Guide for porting Mer on ZedBoard#

##Introduction##
###What we are going to need###
* An account on zedboard.org
* An account on xilinx.com
* An account on cypress.com
* The Xilinx Platform and SDK included in zedboard's kit.
* A Windows 7 x64 working station.
* A virtual machine running CentOS for installing xilinx tools and building the kernel image.


##Preparing the SD card##
* Copy to the SD card the raw image you have already built for pandaboard.
* Delete all the files in the /boot partition of your card.

##Creating the virtual machine and configuring your CentOS environment##
You can create the virtual machine needed and configure it just by following the instructions which can be found [here](http://www.zedboard.org/support/trainings-and-videos).
After signing in with your account preferrences you can click on the link **Implementing Linux on the Zynq-7000 SoC**. This will lead you to another page where you can download slides and code about porting Linux on zedboard. After downloading the guide you can go to the Lab instructions folder and open the first pdf file. Follow exactly the instructions given there to create your vm.

##Building the system.bit file##
Install the  Xilinx ISE Design Suite and Tools using the DVD provided on your Windows machine. After this follow the instructions given in this [guide](http://fpgacpu.wordpress.com/2013/05/24/yet-another-guide-to-running-linaro-ubuntu-desktop-on-xilinx-zynq-on-the-zedboard/) and especially the part **Building the programmable logic hardware**. The files you downloaded need two changes to work. First, you need to change the system.xmp file. These lines (2-3):

	XmpVersion: 14.4
	VerMgmt: 14.4

need to be changed to:

	XmpVersion: 14.2
	VerMgmt: 14.2 

You also need to change the system.mhs file. Line 144:

	PARAMETER HW_VER = 5.04.a

needs to be changed to:

	PARAMETER HW_VER = 5.02.a

This is required because the Xilinx Platform and SDK included in the DVD are a bit older than the ones used in the guide. This step will take much time (roughly 2 hours) so proceed with the next ones.
Note that this step is only required if you want to use the HDMI port of the board. If you are not interested then you can take the already built *system.bit* and *zynq_fsbl_0.elf* files contained in *lab1_3_solution* folder of the guide you downloaded in the previous step.

##Building u-boot, the Linux bootloader##
Just follow the instructions provided [here](http://fpgacpu.wordpress.com/2013/05/24/yet-another-guide-to-running-linaro-ubuntu-desktop-on-xilinx-zynq-on-the-zedboard/) in the respective part. Before building u-boot add this line to your .bash_profile:

	export ARCH=arm

Keep in mind that you should execute this step on your CentOs virtual machine.

##Building the linux kernel##
Follow the instructions provided [here](http://fpgacpu.wordpress.com/2013/05/24/yet-another-guide-to-running-linaro-ubuntu-desktop-on-xilinx-zynq-on-the-zedboard/) in the respective part. Before you configure the kernel edit *arch/arm/configs/zynq_xcomm_adv7511_defconfig* and add these lines at the beginning:

	CONFIG_AUTOFS4_FS=y
	CONFIG_IPV6=y
	CONFIG_CGROUPS=y
	CONFIG_DEVTMPFS=y
	CONFIG_FANOTIFY=y

The third one will enable D-bus messages on your system and you will be able to use *systemctl* to manipulate running services. The others are for silencing some warnings or errors during booting process.

##Building devicetree.dtb##
Follow the instructions provided [here](http://fpgacpu.wordpress.com/2013/05/24/yet-another-guide-to-running-linaro-ubuntu-desktop-on-xilinx-zynq-on-the-zedboard/) in the respective part. Add these lines to *arch/arm/boot/dts/zynq-zed-adv7511.dts*:

	chosen {
                bootargs = "console=ttyPS0,115200 root=/dev/mmcblk0p2 rw earlyprintk rootfstype=ext3 rootwait devtmpfs.mount=0";
        };

This will instruct your kernel to mount the root filesystem from the second partition of your sd card. Note that because we use the rootfs for pandaboard which was configured as ext3 we should use the same in boot arguments. Then put the whole section of *fpga-axi* in comments. This section is responsible for configuring analog devices (such as video, audio sources) but it has some bugs so it doesn't work properly.

##Building the boot image BOOT.BIN##
Follow the instructions provided [here](http://fpgacpu.wordpress.com/2013/05/24/yet-another-guide-to-running-linaro-ubuntu-desktop-on-xilinx-zynq-on-the-zedboard/) in the respective part. Alternatively, if you don't want to use the HDMI port you can skip the process of creating the system bitstream and first stage boot loader and go straight to build the *BOOT.BIN* file from the ones included in the guide you downloaded.

##Testing the system##
###Connecting your PC with the board through the UART serial port###
In order to see what's going on during the system booting you should connect your PC with the UART port of the board. First, you must download a terminal emulator such as Tera Term. Then you must download the appropriate usb-to-uart driver for Windows OS from [here](http://www.cypress.com/?rID=63794). Keep in mind that you have to be logged in. Once the download is completed unzip the file to a known location and then open **Device Manager**. Connect the board to your PC (without inserting any SD card) and when the new device is recognized add the driver you downloaded. For more information on how to do this check [this](http://www.zedboard.org/sites/default/files/CY7C64225_Setup_Guide_1_1.pdf).

###Booting Linux on Zedboard###
Now copy the three files *BOOT.BIN*, *devicetree.dtb* and *uImage* created by the previous steps in the /boot partition of your SD card. Then insert the card into the board and connect it with your computer. Turn the power switch on and open Tera Term. From **Setup->Serial Port** configure the baud rate to 115200 and click ok.
Optionally at this point, the terminal settings can be saved for later use. To do so, click on **Setup->Save**. 
When booting there might be a problem with mounting the /boot partition automatically. You can enter an emergency shell as root and manually mount it. You have to run the following commands:

	mount /boot
	systemctl default

Then the booting process will continue and you will be able to login normally to the system.

###Graphics Support on Zedboard###
Unfortunately, there is no GPU embedded on the Cortex-A9 processor for zedboard. This is rather annoying as you can not run X server to get a graphical user interface. The solution to this is to use the FPGAs as a compensation for the lack of GPU. This requires a lot of knowledge in programming FPGAs because you have to implement your own hardware. As you can imagine this is quite difficult and out of the goals of this guide so it is not included.

