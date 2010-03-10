# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl Math-SternBrocot.t'

#########################

my @x;

BEGIN { @x = (                1,
                     1/2,             2/1,
                1/3,      2/3,   3/2,        3/1,
            1/4,  2/5,  3/5,3/4,4/3,5/3, 5/2,   4/1,
	     ) }

use Test::More tests => 2 + @x;
BEGIN { use_ok('Math::SternBrocot') };

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

{
  my $sb = Math::SternBrocot->new();
  ok($sb);

  for (@x) {
    is($sb->pull_float, $_);
  }
}


