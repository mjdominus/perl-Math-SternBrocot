package Math::SternBrocot;

use 5.010000;
use strict;
use base 'Exporter';

our %EXPORT_TAGS = ( 'all' => [ qw(
				    mediant between
				 ) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw();

our $VERSION = '0.03';

sub new {
  my $class = shift;
  my ($a, $b, $c, $d) = @_;
  ($a, $b) = (0, 1) unless defined $b;
  ($c, $d) = (1, 0) unless defined $d;
  my $self = { Q => [ [ [$a, $b], [$c, $d] ] ] } ;
  bless $self => $class;
}

sub set_filter {
  my ($self, $f) = @_;
  $self->{F} = $f;
}

sub set_bounds {
  my ($self, $lo, $hi) = @_;
  $self->
    set_filter(sub {
		 my $n = shift;
		 between($lo, $n, $hi);
	       });
}

sub _queue { $_[0]{Q} }
sub _filter { $_[0]{F} }

# Pull next fraction in [ $n, $d ] format
sub pull {
  my $self = shift;
  my $Q = $self->_queue;
  my $F = $self->_filter;
  my $m;
  do {
    my $head = shift @$Q;
    my ($hl, $hh) = @$head;
    $m = mediant($hl, $hh);
    $self->push([ $hl, $m ], [ $m, $hh ]);
  } while $F && ! $F->($m);
  return $m;
}

sub push {
  my $self = shift;
  push @{$self->_queue()}, @_;
}

# Pull next fraction in floating-point format
sub pull_float {
  my $self = shift;
  my $next = $self->pull;
  return $next->[0] / $next->[1];
}

sub mediant {
  my ($a, $b) = @_;
  return [$a->[0] + $b->[0], $a->[1] + $b->[1]];
}

sub between {
  my ($a, $b, $c) = @_;
  $a->[0] * $b->[1] <= $a->[1] * $b->[0]
    &&
  $b->[0] * $c->[1] <  $b->[1] * $c->[0];
}

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

Math::SternBrocot - Perl extension for blah blah blah

=head1 SYNOPSIS

  use Math::SternBrocot;
  my $sb = Math::SternBrocot->new();
  

=head1 DESCRIPTION

=head2 EXPORT

None by default.

=head1 SEE ALSO

=head1 AUTHOR

Mark Dominus, E<lt>mjd@plover.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright relinquished 2010 by Mark Dominus

This software is in the public domain


=cut
