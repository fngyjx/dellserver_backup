#~/usr/bin/perl -w

#use strict;

our ($bob);
use vars qw($carol);
$carol = "ted";
$bob = "alice";

print "Bob => $bob, Carol => $carol\n";

package Movie;

print "Bob => $bob, Carol => $carol\n"; #use strict will be error
print "Bob => $main::bob, Carol => $main::carol\n";
__END__

without use strict,we have following, so $bob is accessible from Movie without explicit package, but $carol is not
Bob => alice, Carol => ted
Bob => alice, Carol =>
Bob => alice, Carol => ted


