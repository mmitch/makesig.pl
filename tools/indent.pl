#!/usr/bin/perl -w

# version 1
# 2000 (C) by Christian Garbs <mitch@uni.de>
# indents a text to the right

$indent = 2 unless ($indent = shift());

$file = "-" unless ($file = shift());

if (($indent eq "--help") || ($file eq "--help")) {
    print "Usage:\n";
    print "  right.pl [indentation] [file1] [file2] [file3] [...]\n";
    print "This program will indent a given text to the right\n";
} else {

    $indentstring = "";
    for ($i=0;$i<$indent;$i++) {
	$indentstring = " " . $indentstring;
    }

    indent($file);

    while($file = shift()) {
	left($file);
    }
}

exit 0;

sub indent()
{
    my $filename = $_[0];
    
    open(FILE,"$filename") || die "can't read $filename\n";
    
    while ($line = <FILE>) {
	$line =~ s/[\s\t]*\$//;
	print "$indentstring$line";
    }
    
    close(FILE) || die "can't read $filename\n";
    
}
