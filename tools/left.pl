#!/usr/bin/perl -w
#
# $Revision: 1.4 $
#
# 2000 (C) by Christian Garbs <mitch@cgarbs.de>
# aligns a text to the left
#
# This program is part of the makesig.pl package:
# http://www.h.shuttle.de/mitch/makesig_pl.en.html
#

use strict;

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

sub left()
{
    my $filename = $_[0];
    
    open FILE, "$filename" or die "can't read \"$filename\": $!";
    
    while (my $line = <FILE>) {
	$line =~ s/^[\s\t]*//;
	$line =~ s/[\s\t]*\$//;
	print "$line";
    }
    
    close FILE or die "can't read \"$filename\": $!";
}
