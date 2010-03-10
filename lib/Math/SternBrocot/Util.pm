package Math::SternBrocot::Util;
use Math::SternBrocot;

use 5.010000;
use strict;
use base 'Exporter';

our %EXPORT_TAGS = ( 'all' => [ qw(tabulate best_approx) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = ( @{ $EXPORT_TAGS{'all'} } );

our $VERSION = '0.03';

sub best_approx {
  my ($lb, $ub) = @_;
  my $sb = Math::SternBrocot->new();
  $sb->set_bounds($lb, $ub);
  return $sb->pull();
}

# Tabulate approximations for fractions n/d, (n+1)/d, ..., (d-1)/d
sub tabulate {
  my ($n, $d) = @_;
  my $sb = Math::SternBrocot->new();
  $sb->set_bounds([$n,$d], [1,1]);
  $sb->set_prune_depth($d);
  my @a;
  my $slots_unfilled = $d - $n;
  while ($slots_unfilled > 0) {
    my $f = $sb->pull();
    last unless defined $f;
    my $slot = int($f->[0]/$f->[1] * $d) - $n;
    next if defined $a[$slot];
    $a[$slot] = $f; 
    $slots_unfilled;
#    print STDERR ".";
  }
  return \@a;
}

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
