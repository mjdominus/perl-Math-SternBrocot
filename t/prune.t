
my ($N1, $N2);
BEGIN { $N1 = 40; }
use Test::More tests => $N1 + 2;
use Math::SternBrocot;

{
  my $sb = Math::SternBrocot->new;
  $sb->set_prune_depth(9);

  for (1 .. $N1) {
    my $f = $sb->pull;
    ok($f->[1] <= 9, "$f->[0]/$f->[1] has small denominator");
  }
}

# now count the fractions produced in the interval [0, 1)
# and make sure there are exactly 27 (sum i=2..9 of phi(i))
#      n  2  3  4  5  6  7  8  9
# phi(n)  1  2  2  4  2  6  4  6   = 27
{
  my $sb = Math::SternBrocot->new;
  $sb->set_prune_depth(9);
  $sb->set_bounds([0,1], [1,1]);

  my $count = 0;
  my $h;
  while (1) {
    $h = $sb->pull();
    last unless defined $h;
    last if ++$count >= 100;
  }

  is($count, 27, "count exactly 27 fractions in [0,1)");
  is($h, undef, "stream exhausted");
}

