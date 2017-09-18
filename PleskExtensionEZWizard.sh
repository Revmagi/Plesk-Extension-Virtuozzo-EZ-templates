#!/bin/bash
clear
#### Information for metadata file  #######
echo "##########################################"
echo "##  Plesk Extension EZ-Template Wizard  ##"
echo "## created by Jamie Charleston of Plesk ##"
echo "##########################################"
echo


echo Select the OS are you building this template for?
echo "A) CentOS B) Ubuntu C) Debian D) RHEL "
read os_name
case $os_name in
   a|A) osname="centos" ;;
   b|B) osname="ubuntu" ;;
   c|C) osname="debian" ;;
   d|D) osname="rhel" ;;
esac
clear

echo Time to choose an OS version
case $osname in
	centos)
		echo Which Version of CentOS
		                  echo "A)6 B) 7"
		                  read os_version
			                case $os_version in
			                a|A) osver="6" ;;
  		                b|B) osver="7" ;;
		                  esac
		;;
	debian)
		echo Which Version of Debian
                        echo "A)7 B) 8"
                        read os_version
                        case $os_version in
                        a|A) osver="7" ;;
                        b|B) osver="8" ;;
                        esac
		;;
	ubuntu)
                echo Which Version of Ubuntu
  		echo "A)12.04 B) 14.04 C) 16.04"
                read os_version
                        case $os_version in
                        a|A) osver="12.04" ;;
                        b|B) osver="14.04" ;;
                        c|C) osver="16.04" ;;
                esac

		;;
	rhel)
                echo Which Version of RHEL
                echo "A)6 B) 7"
                read os_version
                        case $os_version in
                        a|A) osver="6" ;;
                        b|B) osver="7" ;;
                esac

osversion=osver
osver=osversion
                ;;

esac
clear

echo What architecture are you building this template for?
echo "A) x86 B) x86_64 "
read os_arch
case $os_arch in
   a|A) osarch="x86" ;;
   b|B) osarch="x86_64" ;;
esac
clear

echo Name this application template.
echo "(No white spaces)"
read appname
clear

echo Please provide description of the application?
read description
clear

echo Please provide primary  Virtuozzo Package Depenancy.
read dependancy
clear

#### Information for post-install file to install extension #######

echo Please provide the extension install url.
read extension_url
clear

echo making new directory $appname
mkdir $appname
echo

echo changing to working directory $appname
cd $appname
echo

echo creating "$appname".metadata file
echo
##### Create Files ######


###### Create metadata  ######
echo "%osname
$osname

%osver
$osver

%osarch
$osarch

%appname
$appname

%description
$description

%packages

%packages_0

%packages_1
$dependancy " > "$appname".metadata

##### Create post-install file ######

echo creating post-install file
echo

echo "
plesk bin extension --install-url $extension_url
" > post-install

echo creating the ez-template
vzmktmpl --post-install post-install "$appname".metadata
