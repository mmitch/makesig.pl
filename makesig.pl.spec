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

__> examples/tools.sh geht nicht weil mit Pfaden!
__> nicht den gesamten examples-Ordner in %doc übernehmen
 
%prep
%setup
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
