#!/usr/bin/perl -w

use strict;

# 2000 (C) by Christian Garbs <mitch@uni.de>
# torsten -> home

# now this is the array config holding an anonymous hash as value [0]
my @config = ({'maxlines',0,'sigdashes',0,'headerfile',"",'footerfile',"",'nolinefeed',1});

# nolinefeed entfernen -> extern!!!

my @verweis=();
my @quotes=();
my $auswahl="";

my $debug=0;

my $homedir=$ENV{"HOME"};

my $config_count = 0;
my $linebreak="\n";

my $file="-";

if (defined $ARGV[0]) {
    $file=shift;
}

my @visited=();

if ($file eq "--help") {
    print "perl_makesign\n";
} else {
    read_file($file,0);

    while ($file = shift) {
	read_file($file,0);
    }

    pick_quote();
    print_quote();
}

exit 0;

#
#
#

sub read_file()
{
    my @subfiles=();
    my $filename = $_[0];
    my $current_config = $_[1];
    my $config_mode = 0;
    my $newquote = "";
    my $cmd;
    my $val;
    my $linecount = 0;
    local *FILE;

    if ($filename =~ /^~\//) {
	$filename =~ s/^~/$homedir/;
    }

    my $vorhanden = 0;
    foreach my $test (@visited) {
	if ($test eq $filename) {
	    $vorhanden = 1;
	}
    }
    
    debug("File: $filename");
    if (! $vorhanden) {
	debug("File is new");

	push(@visited,$filename);

	open(FILE,"$filename") || die "can't read $filename\n";
	
	while (my $input = <FILE>) {
	    if ($input =~ /^[\s\t]*beginconfig\(/i ) {
		# Anfang Config
		debug("Anfang Config");
		$config_mode = 1;
		$config_count ++;
		foreach my $I ("sigdashes","maxlines","footerfile","headerfile","nolinefeed") {
		    $config[$config_count]{$I} = $config[$current_config]{$I};
		}
		$current_config = $config_count;
		debug("new config: $current_config");

	    } elsif ($input =~ /^[\s\t]*\)endconfig/i ) {
		# Ende Config
		debug("Ende Config");

		$config_mode = 0;
		while (@subfiles) {
		    read_file(pop(@subfiles),$current_config);
		}

	    } elsif ($config_mode == 1) {
		# configuration variables

		if ($input !~ /^[\s\t]*\#/ ) {

		    # it's no comment
		    chomp($input);
		    ($cmd,$val) = split(/=/,$input);
		    $cmd=unwhite($cmd);
		    $val=unwhite($val);
		    if ($cmd) {
			if ($cmd =~ /otherfile/i) {
			    push(@subfiles,$val);
			} elsif ($cmd =~ /maxlines/i) {
# Prüfung auf numerisch einbauen?
			    $config[$current_config]{maxlines} = $val;
			    debug("maxlines -> $val");
			} elsif ($cmd =~ /sigdashes/i) {
			    if (($val =~ /yes/i) || ($val == 1)) {
				$config[$current_config]{sigdashes} = 1;
				debug("sigdashes -> yes");
			    } else {
				$config[$current_config]{sigdashes} = 0;
				debug("sigdashes -> no");
			    }
			} elsif ($cmd =~ /nolinefeed/i) {
			    if (($val =~ /yes/i) || ($val == 1)) {
				$config[$current_config]{nolinefeed} = 1;
				debug("nolinefeed -> yes");
			    } else {
				$config[$current_config]{nolinefeed} = 0;
				debug("nolinefeed -> no");
			    }
			} elsif ($cmd =~ /headerfile/i) {
			    $config[$current_config]{headerfile} = $val;
			    debug("headerfile -> $val");
			} elsif ($cmd =~ /footerfile/i) {
			    $config[$current_config]{footerfile} = $val;
			    debug("footerfile -> $val");
			}
		    }
		}
	    } else {
		# A Quote! or a newline?

		if ($input !~ /^[\s\t]*$linebreak/) {

		    $newquote=$newquote . $input;
		    $linecount ++;

		} elsif ($newquote ne "") {

# copy this downto <<HERE>>
		    if (($config[$current_config]{maxlines} == 0) ||
                        ($linecount <= $config[$current_config]{maxlines})) {
			push(@verweis,$current_config);
			push(@quotes,$newquote);
			debug("quote added: $linecount lines");
			debug("current max: $config[$current_config]{maxlines} lines");
			debug("current config: $current_config");
		    }

		    $newquote="";
		    $linecount = 0;

		}
	    }
	}
	
# <<HERE>
	if ($newquote ne "") {

	    if (($config[$current_config]{maxlines} == 0) ||
		($linecount <= $config[$current_config]{maxlines})) {
		push(@verweis,$current_config);
		push(@quotes,$newquote);
	    }
	    
	}
	
	close(FILE) || die "can't close $filename\n";
	
    }
}

sub pick_quote()
{

    srand();

    if (! @quotes) {
	die "no quotes found\n";
    } else {
	$auswahl = int(rand(@quotes));
    }
}

sub print_quote()
{

    my $ausgabe = "";

    if ($config[$verweis[$auswahl]]{sigdashes}) {
	my $ausgabe = $ausgabe . "-- \n";
    }

    if ($config[$verweis[$auswahl]]{headerfile}) {
	open (HEADER, "$config[$verweis[$auswahl]]{headerfile}") || die "can't open $config[$verweis[$auswahl]]{headerfile}\n";
	while (my $input = <HEADER>) {
	    $ausgabe=$ausgabe . $input;
	}
	close (HEADER) || die "can't close $config[$verweis[$auswahl]]{headerfile}\n";
    }

    $ausgabe = $ausgabe . $quotes[$auswahl];

    if ($config[$verweis[$auswahl]]{footerfile}) {
	open (FOOTER, "$config[$verweis[$auswahl]]{footerfile}") || die "can't open $config[$verweis[$auswahl]]{footerfile}\n";
	while (my $input = <FOOTER>) {
	    $ausgabe=$ausgabe . $input;
	}
	close (FOOTER) || die "can't close $config[$verweis[$auswahl]]{footerfile}\n";
    }

    if ($config[$verweis[$auswahl]]{nolinefeed}) {
	chomp ($ausgabe);
    }

    print "$ausgabe";
}

#
#
#

sub unwhite()
{
    if (my $arg = $_[0]) {
	$arg =~ s/^\t//g;
	$arg =~ s/^\s//g;
	$arg =~ s/\t$//g;
	$arg =~ s/\s$//g;
	return $arg;
    }
}

sub debug()
{
    if ($debug) {
	print STDERR "$_[0]\n";
    }
}

