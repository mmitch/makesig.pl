#!/usr/bin/perl -w
#
# $Revision: 1.3.4.2 $
#
# 2000 (C) by Christian Garbs <mitch@uni.de>
# aligns a text to the right
#
# This program is part of the makesig.pl package:
# http://www.cgarbs.de/makesig_pl.en.html
#

use strict;

sub right($);

my ($width, $file);

$width =  79 unless ($width = shift);
$file  = "-" unless ($file  = shift);

if (($width eq "--help") or ($file eq "--help")) {

    print "Usage:\n";
    print "  right.pl [width] [file1] [file2] [file3] [...]\n";
    print "This program will align a given text to the right\n";

    exit 0;

}

die "width is not numeric!\n" unless $width =~ /^\+?\d*$/;

right($file);

foreach $file (@ARGV) {
    right($file);
}

exit 0;

sub right($)
{
    my $filename = shift;
    
    open FILE, "$filename" or die "can't read \"$filename\": $!";
    
    while (my $line = <FILE>) {
	chomp $line;
	$line =~ s/^\s+//;
	$line =~ s/\s+$//;
	if (length $line < $width) {
	    $line = " " x ($width - length $line) . $line;
	}
	print "$line\n";
    }
    
    close FILE or die "can't read \"$filename\": $!";
}
