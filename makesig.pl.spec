Summary: A very flexible random signature generator.
Name: makesig.pl
Version: 0.0.5
Release: 1
Copyright: GPL
Group: Utilities/Text
Source: makesig.pl-0.0.5.tar.gz
Patch: makesig.pl-0.0.5-1.rpmpatch.gz
%description
makesig.pl is a very flexible random signature generator for those who
don't fear the power of the command line. It comes together with some
tools to format your signature. makesig.pl can also read fortune files.

%prep
%setup
%patch -p1

%build

%install
cp makesig.pl /usr/bin/
cp tools/bottom.pl /usr/bin/
cp tools/eatlinefeed.pl /usr/bin/
cp tools/hcenter.pl /usr/bin/
cp tools/hcenterblock.pl /usr/bin/
cp tools/indent.pl /usr/bin/
cp tools/left.pl /usr/bin/
cp tools/leftblock.pl /usr/bin/
cp tools/overlay.pl /usr/bin/
cp tools/right.pl /usr/bin/
cp tools/rightblock.pl /usr/bin/
cp tools/top.pl /usr/bin/
cp tools/vcenter.pl /usr/bin/


%files
%doc HISTORY COPYING tools/README.tools examples/README.makesig examples/README.examples examples/asciiart.txt examples/background.txt examples/demo.txt examples/left.conf examples/moresigs.txt examples/right.conf examples/somesigs.txt examples/tools.sh
/usr/bin/bottom.pl
/usr/bin/eatlinefeed.pl
/usr/bin/hcenter.pl
/usr/bin/hcenterblock.pl
/usr/bin/indent.pl
/usr/bin/left.pl
/usr/bin/leftblock.pl
/usr/bin/makesig.pl
/usr/bin/overlay.pl
/usr/bin/right.pl
/usr/bin/rightblock.pl
/usr/bin/top.pl
/usr/bin/vcenter.pl
