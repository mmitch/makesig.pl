#!/usr/bin/perl -w

# version 2
# 2000 (C) by Christian Garbs <mitch@uni.de>
# overlays multiple text files

$file = "-" unless ($file = shift());

if ($file eq "--help") {
    print "Usage:\n";
    print "  overlay.pl [file1] [file2] [file3] [...]\n";
    print "This program will overlay multiple text files\n";
} else {
    @buffer = ();
    overlay_queue($file);

    while($file = shift()) {
	overlay_queue($file);
    }

    overlay_flush();
}

exit 0;

sub overlay_queue()
{
    my $filename = $_[0];
    
    open(FILE,"$filename") || die "can't read $filename\n";

    $linecnt=0;
    while ($line = <FILE>) {
	chomp($line);
	if ($linecnt+1 > @buffer) {
	    push(@buffer,$line) ;
	} else {
	    while(length($buffer[$linecnt]) < length($line)) {
		$buffer[$linecnt] .= " ";
	    }
	    for ($x=0;$x<length($line);$x++) {
	
		if ($x < length($line)) {
		    if (substr($buffer[$linecnt],$x,1) eq " ") {
			substr($buffer[$linecnt],$x,1) = substr($line,$x,1);
		    }
		} else {
		    $buffer[$linecnt] = $buffer[$linecnt] . substr($line,$x,1);
		}
	    }
	}
	$linecnt++;
    }
    
    close(FILE) || die "can't read $filename\n";
}

sub overlay_flush()
{
    while ($output = shift(@buffer)) {
	print "$output\n";
    }
}

