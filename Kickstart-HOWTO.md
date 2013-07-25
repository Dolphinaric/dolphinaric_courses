#Introduction to making your own kickstart files#

##Chapter 1. Introduction##

###What are Kickstart installations?###
Many system administrators would prefer to use an automated installation method to install the OS to their machines. The answer to this are the kickstart files (originally created by RedHat). Using kickstart, a system administrator can create a single file containing the answers to all the questions that would normally be asked during a typical installation.

###Creating the Kickstart file###
The kickstart file is a simple text file, each identified by a keyword. You can create it by using the Kickstart Configurator application or by writing it from scratch. In your case you will use the appropriate kickstart file provided in the Mer project wiki (according to which board your are building an image).

You must be aware of the following issues when you are creating your kickstart file:

* While not strictly required, there is a natural order for sections that should be followed. Items within the sections do not have to be in a specific order unless otherwise noted. The section order is:

    1. Command section
    2. The %packages section -- Refer to Chapter 3 for details.
    3. The %pre, %post, and %traceback sections -- These sections can be in any order and are not required. 

* The %packages, %pre, %post and %traceback sections are all required to be closed with %end
* Items that are not required can be omitted.
* Omitting any required item will result in the installation program prompting the user for an answer to the related item, just as the user would be prompted during a typical installation. Once the answer is given, the installation will continue unattended unless it finds another missing item.
* Lines starting with a pound sign (#) are treated as comments and are ignored.

##Chapter 2. Kickstart options##
The following is a sort list of options containing only the basic ones you will need. For a complete referrence of all available options please check [Kickstart options](https://fedoraproject.org/wiki/Anaconda/Kickstart#)

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



