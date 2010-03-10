
my $N;
BEGIN { $N = 20 };
use Test::More tests => $N;
use Math::SternBrocot;

{
  my $sb = Math::SternBrocot->new;
  $sb->set_bounds([1,2], [2,3]);

  for (1 .. $N) {
    my $f = $sb->pull;
    my $v = $f->[0]/$f->[1];
    ok(1/2 <= $v && $v < 2/3, "$f->[0]/$f->[1]");
  }
}
