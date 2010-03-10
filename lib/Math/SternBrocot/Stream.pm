
package Math::SternBrocot::Stream;
use base 'Exporter';
use strict;
our @EXPORT = qw(promise node head tail empty filter);

sub promise (&) { return $_[0]; }
sub is_promise { ref($_[0]) eq "CODE" }
sub force { $_[0]->() }

sub node {
    my ($h, $t) = @_;
    return [$h, $t];
}

sub head { $_[0][0] }
sub tail {
    my $s = shift;
    my $t = $s->[1];
    if (is_promise($t)) {
	$s->[1] = $t = force($t);
    }
    return $t;
}

sub empty { not defined $_[0] }
sub drop { $_[0] = tail($_[0]) }

sub filter (&$) {
    my ($p, $s) = @_;
    return if empty($s);
    drop($s) until $p->(head($s));
    return node(head($s), promise { &filter($p, tail($s)) };
}

1;

