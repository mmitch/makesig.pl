#!/usr/bin/perl -w

# version 1
# 2000 (C) by Christian Garbs <mitch@uni.de>
# aligns a text vertically centered
# no trailing empty lines are generated!

$height = 4 unless ($height = shift());

$file = "-" unless ($file = shift());

if (($height eq "--help") || ($file eq "--help")) {
    print "Usage:\n";
    print "  vcenter.pl [height] [file1] [file2] [file3] [...]\n";
    print "This program will align a given text vertically centered\n";
} else {
    center_queue($file);

    while($file = shift()) {
	down_center($file);
    }

    center_flush();
}

exit 0;

sub center_queue()
{
    my $filename = $_[0];
    
    open(FILE,"$filename") || die "can't read $filename\n";
    
    while ($line = <FILE>) {
	push(@cache,$line);
    }
    
    close(FILE) || die "can't read $filename\n";
}

sub center_flush()
{

    while (@cache < $height) {
	print "\n";
	$height -=2;
    }

    while (@cache) {
	print shift(@cache);
    }

    
}
