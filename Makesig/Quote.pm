package Quote;
use strict;

##
## constructor
##

sub new {

    my $proto = shift;
    my $class = ref($proto) || $proto;
    my $self  = {};
    $self->{TEXT} = "";
    bless ($self, $class);
    return $self;

}

##
## attributes
##

sub text {
    my $self = shift;
    if (@_) { $self->{TEXT} = shift }
    return $self->{TEXT};
}

##
## methods
##

sub getLineCount {
    my $self = shift;
    
    # Insert Code here

    return ;
}

1;
