#!/usr/bin/perl -w

# version 1
# 2000 (C) by Christian Garbs <mitch@uni.de>
# aligns a text to the bottom

$height = 4 unless ($height = shift());

$file = "-" unless ($file = shift());

if (($height eq "--help") || ($file eq "--help")) {
    print "Usage:\n";
    print "  bottom.pl [height] [file1] [file2] [file3] [...]\n";
    print "This program will align a given text to the bottom\n";
} else {
    down_queue($file);

    while($file = shift()) {
	down_queue($file);
    }

    down_flush();
}

exit 0;

sub down_queue()
{
    my $filename = $_[0];
    
    open(FILE,"$filename") || die "can't read $filename\n";
    
    while ($line = <FILE>) {
	push(@cache,$line);
    }
    
    close(FILE) || die "can't read $filename\n";
}

sub down_flush()
{
    while (@cache < $height) {
	print "\n";
	$height --;
    }

    while (@cache) {
	print shift(@cache);
    }

}
