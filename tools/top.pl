#!/usr/bin/perl -w

# version 2
# 2000 (C) by Christian Garbs <mitch@uni.de>
# aligns a text upwards

$height = 4 unless ($height = shift());

$file = "-" unless ($file = shift());

$totallines = 0;

if (($height eq "--help") || ($file eq "--help")) {
    print "Usage:\n";
    print "  top.pl [height] [file1] [file2] [file3] [...]\n";
    print "This program will align a given text upwards\n";
} else {

    up($file);

    while($file = shift()) {
	up($file);
    }

    while ($totallines < $height) {
	print "\n";
	$totallines++;
    }
}

exit 0;

sub up()
{
    my $filename = $_[0];
    my $begin = 1;
    
    open(FILE,"$filename") || die "can't read $filename\n";
    
    while ($line = <FILE>) {
	if ($begin == 1) {
	    $test=$line;
	    chomp($test);
	    $test=~ s/[\s\t]//g;
	    if ($test ne "") {
		print "$line";
		$totallines++;
		$begin = 0;
	    }
	} else {
	    print "$line";
	    $totallines++;
	}
    }
    
    close(FILE) || die "can't read $filename\n";
    
}
