package File;
use strict;

##
## constructor
##

sub new {

    my $proto = shift;
    my $class = ref($proto) || $proto;
    my $self  = {};
    $self->{FILENAME}      = "";
    $self->{QUOTES}        = "";
    if (my $parent = shift) {
	$self->{CONFIGURATION} = Configuration->new($parent->CONFIGURATION);
    } else {
	$self->{CONFIGURATION} = Configuration->new();
    }
    bless ($self, $class);
    return $self;

}

##
## attributes
##

sub filename {
    my $self = shift;
    if (@_) { $self->{FILENAME} = shift }
    return $self->{FILENAME};
}

sub configuration {
    my $self = shift;
    if (@_) { $self->{CONFIGURATION} = shift }
    return $self->{CONFIGURATION};
}

##
## methods
##

sub getQuoteCount {
    my $self = shift;
    return scalar @{$self->{QUOTES}};
}

sub getQuote {
    my $self = shift;
    if (@_) {
	return $self->{QUOTES}[shift];
    }
}

sub readFile {
    my $self = shift;

    # INSERT CODE HERE

}

1;
