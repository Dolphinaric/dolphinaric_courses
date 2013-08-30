#Tips when installing Mer SDK#
For the full Mer SDK installation guide please check the official [wiki](https://wiki.merproject.org/wiki/Platform_SDK).

##Introduction##
This is not a full guide for installing Mer SDK. Instead, it is intended to be used alongside with the official guide on the Mer wiki just to explain and help understand some parts that are not so clear. It is highly recommended that you follow exactly the official guide and keep in my mind what is mentioned below. Also, it would be better if you keep up with the guide up to **Advanced details** section.

##Installation Procedure##
###Connect the SDK using 'mount'###
When mounting the sdk it's possible that it will complain about a missing directory.
Here is the actual error: 
	Directory /var/run/dbus is missing in SDK root - please report this bug.

This is not to worry about. It is fixed later when you upgrade your sdk.

##Basic Tasks after successfully installing the SDK##
###Building an Image###
When downloading the kickstart file you may need to use sudo to get permission.

###Compiling with the SDK###
In order to compile with the sdk you need some additional cross-build environments.
For PandaBoard you will need Mer-SB2-armv7hl.
For Raspberry Pi you will need Mer-SB2-armv6l.

###Adding new tools###
You may have trouble installing Mer-debug-tools. It is not so important so you can just ignore it.
