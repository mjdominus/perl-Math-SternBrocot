
my $N;
BEGIN { $N = 20 };
use Test::More tests => $N;
use Math::SternBrocot;

sub odd_denom {
  $_[0][1] % 2 == 1;
}

{
  my $sb = Math::SternBrocot->new;
  $sb->set_filter(\&odd_denom);

  for (1 .. $N) {
    my $f = $sb->pull;
    ok(odd_denom($f), "$f->[0]/$f->[1]");
  }
}
