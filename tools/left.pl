#!/usr/bin/perl -w

# version 1
# 2000 (C) by Christian Garbs <mitch@uni.de>
# aligns a text to the left

$file = "-" unless ($file = shift());

if ($file eq "--help") {
    print "Usage:\n";
    print "  left.pl [file1] [file2] [file3] [...]\n";
    print "This program will align a given text to the left\n";
} else {
    left($file);

    while($file = shift()) {
	left($file);
    }
}

exit 0;

sub left()
{
    my $filename = $_[0];
    
    open(FILE,"$filename") || die "can't read $filename\n";
    
    while ($line = <FILE>) {
	$line =~ s/^[\s\t]*//;
	$line =~ s/[\s\t]*\$//;
	print "$line";
    }
    
    close(FILE) || die "can't read $filename\n";
    
}
