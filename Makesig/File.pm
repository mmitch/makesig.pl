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
    if ($parent = shift) {
	$self->{CONFIGURATION} = Configuration->new($parent->CONFIGURATION);
    } else {
	$self->{CONFIGURATION} = Configuration->new();
    }
    bless ($self, $class);
    return $self;

}

1;
