#!/usr/bin/perl -w

# version 1
# 2000 (C) by Christian Garbs <mitch@uni.de>
# this file removes the final linefeed

$file = "-" unless ($file = shift());

if ($file eq "--help") {
    print "Usage:\n";
    print "  eatlinefeed.pl [file1] [file2] [file3] [...]\n";
    print "This program will remove the final linefeed\n";
} else {
    eatit($file);

    while($file = shift()) {
	eatit($file);
    }

    if ($lastline) {
	print "$lastline";
    }
}

exit 0;

sub eatit()
{
    my $filename = $_[0];
    
    open(FILE,"$filename") || die "can't read $filename\n";

    while ($line = <FILE>) {
	if ($lastline) {
	    print "$lastline\n";
	}
	chomp($line);
	$lastline = $line;
    }
    
    close(FILE) || die "can't read $filename\n";
}
