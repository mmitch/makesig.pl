Summary: A very flexible random signature generator.
Name: makesig.pl
Version: 0.0.1
Release: 1
Copyright: GPL
Group: Utilities/Text
Source: makesig.pl-0.0.1.tar.gz
%description
makesig.pl is a very flexible random signature generator for those who
don't fear the power of the command line. It comes together with some
tools to format your signature.
 
%prep
%setup
%build

%install
cp makesig.pl /usr/bin/
cp bottom.pl /usr/bin/
cp eatlinefeed.pl /usr/bin/
cp hcenter.pl /usr/bin/
cp hcenterblock.pl /usr/bin/
cp indent.pl /usr/bin/
cp left.pl /usr/bin/
cp leftblock.pl /usr/bin/
cp overlay.pl /usr/bin/
cp right.pl /usr/bin/
cp rightblock.pl /usr/bin/
cp top.pl /usr/bin/
cp vcenter.pl /usr/bin/


%files
%doc COPYING tools/README.tools examples/
/usr/bin/makesig.pl
/usr/bin/bottom.pl
/usr/bin/eatlinefeed.pl
/usr/bin/hcenter.pl
/usr/bin/hcenterblock.pl
/usr/bin/indent.pl
/usr/bin/left.pl
/usr/bin/leftblock.pl
/usr/bin/overlay.pl
/usr/bin/right.pl
/usr/bin/rightblock.pl
/usr/bin/top.pl
/usr/bin/vcenter.pl
