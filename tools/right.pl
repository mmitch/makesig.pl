#!/usr/bin/perl -w

# version 1
# 2000 (C) by Christian Garbs <mitch@uni.de>
# aligns a text to the right

$width = 79 unless ($width = shift());

$file = "-" unless ($file = shift());

if (($width eq "--help") || ($file eq "--help")) {
    print "Usage:\n";
    print "  right.pl [width] [file1] [file2] [file3] [...]\n";
    print "This program will align a given text to the right\n";
} else {
    center($file);

    while($file = shift()) {
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
	while (length($line)<$width) {
	    $line = " " . $line;
	}
	print "$line\n";
    }
    
    close(FILE) || die "can't read $filename\n";
    
}
