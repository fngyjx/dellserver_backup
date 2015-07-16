#!/usr/bin/perl -w

use strict;

#remember we're in package main

use vars qw($foo);

$foo = "Yo!"; # sets $main::foo

print "\$foo: $foo\n"; # prints "Yo!"

my $foo = "Hey!"; # this is a file-level my variable!

print "\$foo: $foo\n"; # prints "Hey!" -- new declaration 'masks' the old one

{ # start a block
  my $foo = "Yacht-Z";
  print "\$foo: $foo\n"; 
  # prints "Yacht-Z" -- we have a new $foo in scope.
  print "\$main::foo: $main::foo\n"; 
  # we can still 'see' $main::foo
  subroutine();
} # end that block

print "\$foo: $foo\n"; # there it is, our file-level $foo is visible again!

print "\$main::foo: $main::foo\n"; # whew!  $main::foo is still there!

sub subroutine {
  print "\$foo: $foo\n"; # prints "Hey!" -- as the script is written
 # why?  Because the variable declared in the naked block
 # is no longer in scope -- we have a new set of braces.
 # but the file-level variable is still in scope, and
 # still 'masks' the declaration of $main::foo
}

package Bar;

print "\$foo: $foo \$main::foo: $main::foo\n"; # prints "Hey!" -- the my variable's still in scope
# if we hadn't made that declaration above, this would be an error: the
# interpreter would tell us that Bar::foo has not been defined.


