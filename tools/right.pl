#!/usr/bin/perl -w
#
# $Revision: 1.2 $
#
# 2000 (C) by Christian Garbs <mitch@uni.de>
# aligns a text to the right

use strict;

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

center($file);

foreach $file (@ARGV) {
    center($file);
}

exit 0;

sub center()
{
    my $filename = $_[0];
    
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
