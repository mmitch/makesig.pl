package Configuration;
use strict;

##
## constructor
##

sub new {

    my $proto = shift;
    my $class = ref($proto) || $proto;
    my $self  = {};
    if (@_) {
	my $parent = shift;
	$self->{FORTUNESTYLE}   = $parent->{FORTUNESTYLE};
	$self->{NOLINEFEED}     = $parent->{NOLINEFEED};
	$self->{SIGDASHES}      = $parent->{SIGDASHES};
	$self->{MAXLINES}       = $parent->{MAXLINES};
	$self->{HEADERFILE}     = $parent->{HEADERFILE};
	$self->{FOOTERFILE}     = $parent->{FOOTERFILE};
    } else {
	$self->{FORTUNESTYLE}   =  0;
	$self->{NOLINEFEED}     =  0;
	$self->{SIGDASHES}      =  0;
	$self->{MAXLINES}       =  0;
	$self->{HEADERFILE}     = "";
	$self->{FOOTERFILE}     = "";
    }
    bless ($self, $class);
    return $self;

}

##
## attributes
##

sub fortunestyle {
    my $self = shift;
    if (@_) { $self->{FORTUNESTYLE} = shift }
    return $self->{FORTUNESTYLE};
}

sub nolinefeed {
    my $self = shift;
    if (@_) { $self->{NOLINEFEED} = shift }
    return $self->{NOLINEFEED};
}

sub sigdashes {
    my $self = shift;
    if (@_) { $self->{SIGDASHES} = shift }
    return $self->{SIGDASHES};
}

sub maxlines {
    my $self = shift;
    if (@_) { $self->{MAXLINES} = shift }
    return $self->{MAXLINES};
}

sub headerfile {
    my $self = shift;
    if (@_) { $self->{HEADERFILE} = shift }
    return $self->{HEADERFILE};
}

sub footerfile {
    my $self = shift;
    if (@_) { $self->{FOOTERFILE} = shift }
    return $self->{FOOTERFILE};
}

##
## methods
##

sub getDelimiter {
    my $self = shift;
    if ($self->{FORTUNESTYLE}) {
	return "^%\$";
    } else {
	return "^\s*\$";
    }
}

1;
