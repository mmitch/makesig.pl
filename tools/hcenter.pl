#!/usr/bin/perl -w

# version 1
# 2000 (C) by Christian Garbs <mitch@uni.de>
# centers a text horizontally

$width = 79 unless ($width = shift());

$file = "-" unless ($file = shift());

if (($width eq "--help") || ($file eq "--help")) {
    print "Usage:\n";
    print "  hcenter.pl [width] [file1] [file2] [file3] [...]\n";
    print "This program will center a given text horizontally\n";
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
