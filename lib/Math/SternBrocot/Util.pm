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

sub tabulate {
  my ($max_num, $denom) = @_;
  $denom = $max_num unless defined $denom;
  my $sb = Math::SternBrocot->new();
  $sb->set_bounds([0,1], [$max_num,$denom]);
  $sb->set_prune_depth($denom);
  my @a;
  my $N = $max_num;
  while ($N > 0) {
    my $f = $sb->pull();
    my $slot = int($f->[0]/$f->[1] * $denom);
    next if defined $a[$slot];
    $a[$slot] = $f; 
    $N--;
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
