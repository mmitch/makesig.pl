#!/usr/bin/perl -w
#
# $Revision: 1.4 $
#
# 2000 (C) by Christian Garbs <mitch@uni.de>
# indents a text to the right
#
# This program is part of the makesig.pl package:
# http://www.h.shuttle.de/mitch/makesig_pl.en.html
#

use strict;

my ($indent, $file, $indentstring);

$indent =   2 unless ($indent = shift);
$file   = "-" unless ($file   = shift);

if (($indent eq "--help") or ($file eq "--help")) {

    print "Usage:\n";
    print "  right.pl [indentation] [file1] [file2] [file3] [...]\n";
    print "This program will indent a given text to the right\n";

    exit 0;

}

$indentstring = "";
for (my $i=0; $i < $indent; $i++) {
    $indentstring = " " . $indentstring;
}

indent($file);
foreach $file (@ARGV) {
    left($file);
}

exit 0;

sub indent()
{
    my $filename = $_[0];
    
    open FILE, "$filename" or die "can't read \"$filename\": $!";
    
    while (my $line = <FILE>) {
	$line =~ s/\s*\$//;
	print "$indentstring$line";
    }
    
    close FILE or die "can't read \"$filename\": $!";
}
