#!/usr/bin/perl -w
#
# $Revision: 1.3.4.2 $
#
# 2000 (C) by Christian Garbs <mitch@uni.de>
# overlays multiple text files
#
# This program is part of the makesig.pl package:
# http://www.cgarbs.de/makesig_pl.en.html
#

use strict;

sub overlay_queue($);
sub overlay_flush();

my ($file, @buffer);

$file = "-" unless ($file = shift);

if ($file eq "--help") {

    print "Usage:\n";
    print "  overlay.pl [file1] [file2] [file3] [...]\n";
    print "This program will overlay multiple text files\n";

    exit 0;
}

overlay_queue($file);

foreach $file (@ARGV) {
    overlay_queue($file);
}

overlay_flush();

exit 0;

sub overlay_queue($)
{
    my $filename = shift;
    
    open FILE, "$filename" or die "can't read \"$filename\": $!";

    my $linecnt=0;
    while (my $line = <FILE>) {
	chomp $line;
	if ($linecnt + 1 > @buffer) {
	    push @buffer, $line;
	} else {
	    my $min = length $buffer[$linecnt];
	    $min = length $line unless length $line > $min;
	    for (my $x = 0; $x < $min; $x++) {
		if (substr($buffer[$linecnt], $x, 1) eq " ") {
		    substr($buffer[$linecnt], $x, 1) = substr $line, $x, 1;
		}
	    }
	    if (length $buffer[$linecnt] < length $line) {
		$buffer[$linecnt] .= substr $line, length $buffer[$linecnt];
	    }
	}
	$linecnt++;
    }
    
    close FILE or die "can't read \"$filename\": $!";
}

sub overlay_flush()
{
    foreach my $output (@buffer) {
	print "$output\n";
    }
}
