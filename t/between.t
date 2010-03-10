
my $N;
BEGIN { $N = 12 };
use Test::More tests => 1 + ($N+1);
use_ok('Math::SternBrocot', 'between');

for (0 .. $N) {
  bool_ok(between([1,2], [$_,$N], [2,3]),
	  1/2 <= $_/$N && $_/$N < 2/3,
	  sprintf("%2d/$N in [1/2, 2/3]", $_));
}

sub bool_ok {
    my ($a, $x, $m) = @_;
    my $mc = sub { $m ? "$m: $_[0]" : $_[0] };
    my $t = Test::Builder->new();
    if ($a && ! $x) { ok(0, $mc->("was true, should have been false")) }
    elsif (! $a && $x) { ok($mc->("was false, should have been true")) }
    else { ok(1, $m); }
}
