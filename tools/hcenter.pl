#!/usr/bin/perl -w
#
# $Revision: 1.3.4.2 $
#
# 2000 (C) by Christian Garbs <mitch@uni.de>
# centers a text horizontally
#
# This program is part of the makesig.pl package:
# http://www.cgarbs.de/makesig_pl.en.html
#

use strict;

sub center($);

my ($width, $file);

$width =  79 unless ($width = shift);
$file  = "-" unless ($file  = shift);

if (($width eq "--help") or ($file eq "--help")) {

    print "Usage:\n";
    print "  hcenter.pl [width] [file1] [file2] [file3] [...]\n";
    print "This program will center a given text horizontally\n";

    exit 0;
}

die "width is not numeric!\n" unless $width =~ /^\+?\d*$/;

center($file);

foreach $file (@ARGV) {
    center($file);
}

exit 0;

sub center($)
{
    my $filename = shift;
    
    open FILE, "$filename" or die "can't read \"$filename\": $!";
    
    while (my $line = <FILE>) {
	chomp $line;
	$line =~ s/^\s*//;
	$line =~ s/\s*$//;
	my $spacestoadd = ($width - length $line) / 2;
	if ($spacestoadd > 0) {
	    for (my $i=0; $i < $spacestoadd; $i++) {
		$line = " " . $line;
	    }
	}
	print "$line\n";
    }
    
    close FILE or die "can't read \"$filename\": $!";
    
}
