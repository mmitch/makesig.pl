#!/usr/bin/perl -w
#
# $Revision: 1.3 $
#
# 2000 (C) by Christian Garbs <mitch@uni.de>
# centers a block horizontally

use strict;

my ($width, $file, @data, $longest);

$width   =  79 unless ($width = shift);
$file    = "-" unless ($file  = shift);
$longest =   0;

if (($width eq "--help") or ($file eq "--help")) {

    print "Usage:\n";
    print "  hcenterblock.pl [width] [file1] [file2] [file3] [...]\n";
    print "This program will center a given block horizontally\n";

    exit 0;
}

die "width is not numeric!\n" unless $width =~ /^\+?\d*$/;

input($file);

foreach $file (@ARGV) {
    input($file);
}

center();

exit 0;

sub input()
{
    my $filename = $_[0];
    
    open FILE, "$filename" or die "can't read $filename: $!";
    
    while (my $line = <FILE>) {
	chomp $line;
	if (length $line > $longest) {
	    $longest = length $line;
	}
	push @data, $line;
    }
}

sub center()
{
    my $spacestoadd = " " x (($width - $longest) / 2);
    foreach my $line (@data) {
	print "$spacestoadd$line\n";
    }
}
