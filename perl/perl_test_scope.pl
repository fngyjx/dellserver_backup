#!/usr/bin/perl -w

our $Robert = "the owner"; #my makes the $Robert lexical var in the file.
print "\$Robert of my is $Robert\n";
package Szyewicki;

our $Robert = "the boss"; #our makes the $Robert the package var and in lexical scope
print "\$Robert of Szyewicki is $Robert\n";

package PoolHall;

our $Robert = "the darts expert"; # our makes the $Robert is package var and lexical scope.
print "\$Robert of PollHall is $Robert\n";

package Sywiecki; # back to work!

print "Here at work, 'Robert' is $main::Robert, but over at the pool hall, 'Robert'
is $PoolHall::Robert\n"; #both my and our make the var lexical, the $Robert would be 'the darts expert'

__END__
Name "PoolHall::Robert" used only once: possible typo at perl_test_scope.pl line 17.
$Robert of my is the owner
$Robert of Szyewicki is the boss
$Robert of PollHall is the darts expert
Here at work, 'Robert' is the owner, but over at the pool hall, 'Robert'
is

