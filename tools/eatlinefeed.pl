#!/usr/bin/perl -w
#
# $Revision: 1.3 $
#
# 2000 (C) by Christian Garbs <mitch@uni.de>
# this script removes the final linefeed
#
# This program is part of the makesig.pl package:
# http://www.h.shuttle.de/mitch/makesig_pl.en.html
#

use strict;

my ($file, $lastline);

$file = "-" unless ($file = shift());

if ($file eq "--help") {

    print "Usage:\n";
    print "  eatlinefeed.pl [file1] [file2] [file3] [...]\n";
    print "This program will remove the final linefeed\n";

    exit 0;
}

eatit($file);

foreach $file (@ARGV) {
    eatit($file);
}

if ($lastline) {
    print "$lastline";
}

exit 0;

sub eatit()
{
    my $filename = $_[0];
    
    open FILE, "$filename" or die "can't read \"$filename\": $!";

    while ($line = <FILE>) {
	if ($lastline) {
	    print "$lastline\n";
	}
	chomp $line;
	$lastline = $line;
    }
    
    close FILE or die "can't read \"$filename\": $!";
}
