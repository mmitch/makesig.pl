#!/usr/bin/perl -w
#
# $Revision: 1.4 $
#
# 2000 (C) by Christian Garbs <mitch@cgarbs.de>
# aligns a text upwards
#
# This program is part of the makesig.pl package:
# http://www.h.shuttle.de/mitch/makesig_pl.en.html
#

use strict;

my ($height, $file, $totallines);

$height     =   4 unless ($height = shift);
$file       = "-" unless ($file   = shift);
$totallines =   0;

if (($height eq "--help") or ($file eq "--help")) {

    print "Usage:\n";
    print "  top.pl [height] [file1] [file2] [file3] [...]\n";
    print "This program will align a given text upwards\n";

    exit 0;
}

die "height is not numeric!\n" unless $height =~ /^\+?\d*$/;

up($file);

foreach $file (@ARGV) {
    up($file);
}

while ($totallines < $height) {
    print "\n";
    $totallines++;
}

exit 0;

sub up()
{
    my $filename = $_[0];
    my $begin = 1;
    
    open FILE, "$filename" or die "can't read \"$filename\": $!";
    
    while (my $line = <FILE>) {
	if ($begin == 1) {
	    if ($line !~ /^\s*$/) {
		print "$line";
		$totallines++;
		$begin = 0;
	    }
	} else {
	    print "$line";
	    $totallines++;
	}
    }
    
    close FILE or die "can't read \"$filename\": $!";
    
}
