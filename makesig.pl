#!/usr/bin/perl -w
#
# $Revision: 1.9.6.4 $
#
# 2000 (C) by Christian Garbs <mitch@uni.de>
#
# This program is part of the makesig.pl package:
# http://www.h.shuttle.de/mitch/makesig_pl.en.html
#

use strict;

# version information
my $version = "0.0.5  -  2000-11-10";

sub read_file ($$);
sub pick_quote();
sub print_quote();
sub unwhite($);

# now this is the array config holding an anonymous hash as value [0]
my @config = ({
    'maxlines'     =>  0,
    'sigdashes'    =>  0,
    'headerfile'   => "",
    'footerfile'   => "",
    'nolinefeed'   =>  0,
    'fortunestyle' =>  0
    });

my @verweis=();
my @quotes=();
my $auswahl="";

my $homedir=$ENV{"HOME"};

my $config_count = 0;

my $file="-";

if (defined $ARGV[0]) {
    $file=shift;
}

my @visited=();

if ($file eq "--help") {

    print << "EOF";
makesig.pl $version
Usage:
  makesig.pl [signature_file] [signature_file] [...]

Quick overview of configuration blocks:
beginconfig(
  # just a comment
  otherfile=<filename>
  headerfile=<filename>
  footerfile=<filename>
  maxlines=<n>
  sigdashes=<yes|no>
  nolinefeed=<yes|no>
  fortunestyle=<yes|no>
)endconfig

EOF

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

sub read_file($$)
{
    my @subfiles=();
    my $filename = $_[0];
    my $current_config = $_[1];
    my $config_mode = 0;
    my $newquote = "";
    my $cmd;
    my $val;
    my $linecount = 0;
    my $delimiter;
    local *FILE;

    if ($filename =~ /^~\//) {
	$filename =~ s/^~/$homedir/;
    }

    if (! grep /$filename/, @visited) {

	push @visited, $filename;

	open FILE, "$filename" or die "can't read \"$filename\": $!";
	
	if ($config[$current_config]{"fortunestyle"}) {
	    $delimiter = "^%\$";
	} else {
	    $delimiter = '^\s*$';
	}

	while (my $input = <FILE>) {
	    if ($input =~ /^\s*beginconfig\(/i ) {
		# Anfang Config
		$config_mode = 1;
		$config_count ++;
		foreach my $I ("sigdashes", "maxlines", "footerfile", "headerfile", "nolinefeed", "fortunestyle") {
		    $config[$config_count]{$I} = $config[$current_config]{$I};
		}
		$current_config = $config_count;

	    } elsif ($input =~ /^\s*\)endconfig/i ) {
		# Ende Config

		$config_mode = 0;
		while (@subfiles) {
		    read_file(pop @subfiles, $current_config);
		}

	    } elsif ($config_mode == 1) {
		# configuration variables

		if ($input !~ /^\s*\#/ ) {

		    # it's no comment
		    chomp $input;
		    ($cmd, $val) = split /=/, $input;
		    $cmd = unwhite($cmd);
		    $val = unwhite($val);
		    if ($cmd) {

			# Obacht! Wir prüfen auf *cmd*, da kann vorher und nachher kommen, was will

			if ($cmd =~ /otherfile/i) {
			    push @subfiles, $val;

			} elsif ($cmd =~ /maxlines/i) {

			    if ($val =~ /^\+?\d+$/) {
				$config[$current_config]{maxlines} = $val;
			    } else {
				warn "makesig.pl: maxlines=$val is not numeric in signature file \"$filename\" at line $.\n";
			    }

			} elsif ($cmd =~ /sigdashes/i) {
			    if ($val =~ /yes/i) {
				$config[$current_config]{sigdashes} = 1;
			    } else {
				$config[$current_config]{sigdashes} = 0;
			    }

			} elsif ($cmd =~ /nolinefeed/i) {
			    if ($val =~ /yes/i) {
				$config[$current_config]{nolinefeed} = 1;
			    } else {
				$config[$current_config]{nolinefeed} = 0;
			    }

			} elsif ($cmd =~ /fortunestyle/i) {
			    if ($val =~ /yes/i) {
				$config[$current_config]{fortunestyle} = 1;
				$delimiter = "^%\$";
			    } else {
				$config[$current_config]{fortunestyle} = 0;
				$delimiter = '^\s*$';
			    }

			} elsif ($cmd =~ /headerfile/i) {
			    $config[$current_config]{headerfile} = $val;

			} elsif ($cmd =~ /footerfile/i) {
			    $config[$current_config]{footerfile} = $val;

			} else {
			    warn "makesig.pl: unknown configuration command \"$cmd\" in signature file \"$filename\" at line $.\n";
			}
		    }
		}
	    } else {
		# A Quote! or a delimiter?

		if ($input !~ /$delimiter/) {

		    $newquote=$newquote . $input;
		    $linecount ++;

		} elsif ($newquote ne "") {

# copy this downto <<HERE>>
		    if (($config[$current_config]{maxlines} == 0) or
                        ($linecount <= $config[$current_config]{maxlines})) {
			push @verweis, $current_config;
			push @quotes, $newquote;
		    }

		    $newquote="";
		    $linecount = 0;

		}
	    }
	}
	
# <<HERE>
	if ($newquote ne "") {

	    if (($config[$current_config]{maxlines} == 0) or
		($linecount <= $config[$current_config]{maxlines})) {
		push @verweis, $current_config;
		push @quotes, $newquote;
	    }
	    
	}
	
	close FILE or die "can't close \"$filename\": $!";
	
    }
}

sub pick_quote()
{

    srand();

    if (! @quotes) {
	die "no quotes found\n";
    } else {
	$auswahl = int(rand @quotes);
    }
}

sub print_quote()
{

    my $ausgabe = "";

    if ($config[$verweis[$auswahl]]{sigdashes}) {
	$ausgabe .= "-- \n";
    }

    if ($config[$verweis[$auswahl]]{headerfile}) {
	open HEADER, "$config[$verweis[$auswahl]]{headerfile}"
	    or die "can't open \"$config[$verweis[$auswahl]]{headerfile}\": $!";
	while (my $input = <HEADER>) {
	    $ausgabe .= $input;
	}
	close HEADER or die "can't close \"$config[$verweis[$auswahl]]{headerfile}\": $!";
    }
    
    $ausgabe .= $quotes[$auswahl];
    
    if ($config[$verweis[$auswahl]]{footerfile}) {
	open FOOTER, "$config[$verweis[$auswahl]]{footerfile}"
	    or die "can't open \"$config[$verweis[$auswahl]]{footerfile}\": $!";
	while (my $input = <FOOTER>) {
	    $ausgabe .= $input;
	}
	close FOOTER or die "can't close \"$config[$verweis[$auswahl]]{footerfile}\": $!";
    }

    if ($config[$verweis[$auswahl]]{nolinefeed}) {
	chomp $ausgabe;
    }

    print "$ausgabe";
}

#
#
#

sub unwhite($)
{
    if (my $arg = $_[0]) {
	$arg =~ s/^\s+//;
	$arg =~ s/\s+$//;
	return $arg;
    }
}
