# Running root_numpy on Virtal Machine for data conversion from rootTree to numpy arrays

- VM needs to be slc7 (eg.: CC7 - x86_64 [2017-04-06])
- python version needs to be >= 2.7
- numpy is installed

install packages which are missing on slc7 - list packages for slc7 to be as slc6:

>> sudo yum install -y glibc coreutils bash tcsh zsh perl tcl tk readline openssl ncurses e2fsprogs krb5-libs freetype fontconfig libstdc++ libidn libX11 libXmu libSM libICE libXcursor libXext libXrandr libXft mesa-libGLU mesa-libGL e2fsprogs-libs libXi libXinerama libXrender libXpm gcc-c++ libcom_err libXpm-devel libXft-devel libX11-devel libXext-devel mesa-libGLU mesa-libGLU-devel libGLEW glew perl-Digest-MD5 perl-ExtUtils-MakeMaker patch perl-libwww-perl krb5-libs krb5-devel perl-Data-Dumper perl-WWW-Curl texinfo hostname time perl-Carp perl-Text-ParseWords perl-PathTools perl-ExtUtils-MakeMaker perl-Exporter perl-File-Path perl-Getopt-Long perl-constant perl-File-Temp perl-Socket perl-Time-Local perl-Storable glibc-headers perl-threads perl-Thread-Queue perl-Module-ScanDeps perl-Test-Harness perl-Env perl-Switch perl-ExtUtils-Embed ncurses-libs perl-libs nspr nss nss-util file file-libs readline zlib popt bzip2 bzip2-libs


install ROOT framework, unzip and run:
>> . /root/bin/thisroot.sh

(at this point in python interpreter should work "import ROOT")

>> pip install root_numpy