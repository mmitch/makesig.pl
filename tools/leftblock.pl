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
sub left();

my ($file, @data, $cutoff);

$file = "-" unless ($file = shift());

if ($file eq "--help") {

    print "Usage:\n";
    print "  leftblock.pl [file1] [file2] [file3] [...]\n";
    print "This program will align a given block to the left\n";

    exit 0;

}

input($file);

foreach $file (@ARGV) {
    input($file);
}

$cutoff = 0 unless $cutoff;

left();

exit 0;

sub input($)
{
    my $filename = $_[0];
    
    open FILE, "$filename" or die "can't read $filename: $!";
    
    while (my $line = <FILE>) {
	chomp $line;
	
	if ($line =~ /( +)/) {
	    if ($cutoff) {
		if ($cutoff > length $1) {
		    $cutoff = length $1;
		}
	    } else {
		$cutoff = length $1;
	    }
	}
	push @data, $line;
    }
}

sub left()
{
    foreach my $line (@data) {
	$line = substr $line, $cutoff;
	print "$line\n";
    }
}
