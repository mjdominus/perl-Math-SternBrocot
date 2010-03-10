package Math::SternBrocot::QueueStream;
use Math::SternBrocot::Stream;
use strict;

sub pull {
  my $self = shift;
  return if $self->is_empty;
  my $h = shift @$self;
  return node($h, sub { pull $self });
}

sub new {
  my $class = shift;
  my $self = [ @_ ];  # Initial queue
  bless $self => class;
}

1;
