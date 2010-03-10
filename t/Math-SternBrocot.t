# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl Math-SternBrocot.t'

#########################

use Test::More tests => 3;
BEGIN { use_ok('Math::SternBrocot') };

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

my $sb = Math::SternBrocot->new();
ok($sb);
is($sb->pull_float, 1);
