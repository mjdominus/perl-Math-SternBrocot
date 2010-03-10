package Math::SternBrocot;

use 5.010000;
use strict;

our %EXPORT_TAGS = ( 'all' => [ qw(
	
				 ) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	
	       );

our $VERSION = '0.02';


sub new {
  my $class = shift;
  my ($a, $b, $c, $d) = @_;
  ($a, $b) = (0, 1) unless defined $b;
  ($c, $d) = (1, 0) unless defined $d;
  my $self = { Q => [ [ [$a, $b], [$c, $d] ] ] } ;
  bless $self => $class;
}

sub _queue { $_[0]{Q} }

# Pull next fraction in [ $n, $d ] format
sub pull {
  my $self = shift;
  my $Q = $self->_queue;
  my $head = shift @$Q;
  my ($hl, $hh) = @$head;
  my $m = mediant($hl, $hh);
  $self->push([ $hl, $m ], [ $m, $hh ]);
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
