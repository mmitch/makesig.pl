#!/usr/bin/perl -w
#
# $Revision: 1.3 $
#
# 2000 (C) by Christian Garbs <mitch@uni.de>
# aligns a text to the bottom

use strict;

my ($height, $file, @cache);

$height =   4 unless ($height = shift);
$file   = "-" unless ($file   = shift);

if (($height eq "--help") or ($file eq "--help")) {

    print "Usage:\n";
    print "  bottom.pl [height] [file1] [file2] [file3] [...]\n";
    print "This program will align a given text to the bottom\n";

    exit 0;

}

die "height is not numeric!\n" unless $height =~ /^\+?\d*$/;

down_queue($file);

foreach $file (@ARGV) {
    down_queue($file);
}
down_flush();

exit 0;

sub down_queue()
{
    my $filename = $_[0];
   
    open FILE, "$filename" or die "can't read \"$filename\": $!";
    
    while (my $line = <FILE>) {
	push @cache, $line;
    }
    
    close FILE or die "can't read \"$filename\": $!";
}

sub down_flush()
{
    while (@cache < $height) {
	print "\n";
	$height--;
    }

    print @cache;
}
