#!/usr/bin/perl -w
#
# $Revision: 1.3.4.2 $
#
# 2000 (C) by Christian Garbs <mitch@uni.de>
# centers a block horizontally
#
# This program is part of the makesig.pl package:
# http://www.cgarbs.de/makesig_pl.en.html
#

use strict;

sub input($);
sub right();

my ($width, $file, @data, $longest);

$width   = 79  unless ($width = shift);
$file    = "-" unless ($file  = shift);
$longest = 0;

if (($width eq "--help") or ($file eq "--help")) {

    print "Usage:\n";
    print "  rightblock.pl [width] [file1] [file2] [file3] [...]\n";
    print "This program will align a given block to the right\n";

    exit 0;
}

die "width is not numeric!\n" unless $width =~ /^\+?\d*$/;

input($file);

foreach $file (@ARGV) {
    input($file);
}

right();

exit 0;

sub input($)
{
    my $filename = shift;
    
    open FILE, "$filename" or die "can't read $filename: $!";
    
    while (my $line = <FILE>) {
	chomp $line;
	if (length $line > $longest) {
	    $longest = length $line;
	}
	push @data, $line;
    }
}

sub right()
{
    my $spacestoadd = " " x ($width - $longest);
    foreach my $line (@data) {
	print "$spacestoadd$line\n";
    }
}
