#!/usr/bin/perl -w
#
# $Revision: 1.3.4.2 $
#
# 2000 (C) by Christian Garbs <mitch@uni.de>
# aligns a text to the left
#
# This program is part of the makesig.pl package:
# http://www.cgarbs.de/makesig_pl.en.html
#

use strict;

sub left($);

my $file;

$file = "-" unless ($file = shift);

if ($file eq "--help") {

    print "Usage:\n";
    print "  left.pl [file1] [file2] [file3] [...]\n";
    print "This program will align a given text to the left\n";

    exit 0;

}

left($file);

foreach $file (@ARGV) {
    left($file);
}

exit 0;

sub left($)
{
    my $filename = shift;
    
    open FILE, "$filename" or die "can't read \"$filename\": $!";
    
    while (my $line = <FILE>) {
	$line =~ s/^[\s\t]*//;
	$line =~ s/[\s\t]*\$//;
	print "$line";
    }
    
    close FILE or die "can't read \"$filename\": $!";
}
