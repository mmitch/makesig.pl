#!/usr/bin/perl -w

# version 2
# 2000 (C) by Christian Garbs <mitch@uni.de>
# centers a block of text horizontally

use strict;

my $width=79;
my $file="-";

if (defined $ARGV[0]) {
    $width = shift;
}

if (defined $ARGV[0]) {
    $file = shift;
}

if (($width eq "--help") || ($file eq "--help")) {
    print "Usage:\n";
    print "  hcenterblock.pl [width] [file1] [file2] [file3] [...]\n";
    print "This program will center a given block of text horizontally\n";
} else {
    center($file);

    while($file = shift) {
	center($file);
    }
}

exit 0;

sub center()
{
    my $filename = $_[0];
    
    open(FILE,"$filename") || die "can't read $filename\n";
    
    while ($line = <FILE>) {
	chomp($line);
	$line =~ s/^[\s\t]*//;
	$line =~ s/[\s\t]*\$//;
	my $spacestoadd = ($width - length($line)) / 2;
	if ($spacestoadd > 0) {
	    for (my $i=0;$i<$spacestoadd;$i++) {
		$line = " " . $line;
	    }
	}
	print "$line\n";
    }
    
    close(FILE) || die "can't read $filename\n";
    
}
