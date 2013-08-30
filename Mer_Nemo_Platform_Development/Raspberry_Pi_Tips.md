#Tips for porting Mer on Raspberry Pi#

##Kickstart File##
Line 66 in the kickstart file:

	Exec=/usr/bin/qmlviewer

should be changed to:

	Exec=/usr/lib/qt4/bin/qmlviewer

The rest should work out of the box.
