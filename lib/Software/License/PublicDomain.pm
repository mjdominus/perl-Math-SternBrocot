use strict;
use warnings;
package Software::License::PublicDomain;
use base 'Software::License';

=head1 NAME

Software::License::PublicDomain - The absence of license

=cut

sub name { 'Public Domain' }
sub url  { 'http://en.wikipedia.org/wiki/Public_domain' }
sub notice {
    "Copyright abandoned " . $_[0]->year . " " . $_[0]->holder . "\n"
}
sub meta_name { 'unrestricted' }

1;
__DATA__
__LICENSE__

This software is in the public domain.  


