#!/usr/bin/perl -w
#
# $Revision: 1.4 $
#
# 2000 (C) by Christian Garbs <mitch@cgarbs.de>
# aligns a text vertically centered
# no trailing empty lines are generated!
#
# This program is part of the makesig.pl package:
# http://www.h.shuttle.de/mitch/makesig_pl.en.html
#

use strict;

my ($height, $file, @cache);

$height =   4 unless ($height = shift);
$file   = "-" unless ($file   = shift);

if (($height eq "--help") or ($file eq "--help")) {

    print "Usage:\n";
    print "  vcenter.pl [height] [file1] [file2] [file3] [...]\n";
    print "This program will align a given text vertically centered\n";

    exit 0;
}

die "height is not numeric!\n" unless $height =~ /^\+?\d*$/;

center_queue($file);

foreach $file (@ARGV) {
    down_center($file);
}

center_flush();

exit 0;

sub center_queue()
{
    my $filename = $_[0];
    
    open FILE, "$filename" or die "can't read \"$filename\": $!";
    
    while (my $line = <FILE>) {
	push @cache, $line;
    }
    
    close FILE or die "can't read \"$filename\": $!";
}

sub center_flush()
{
    while (@cache < $height) {
	print "\n";
	$height -=2;
    }

    while (@cache) {
	print shift(@cache);
    }
}
