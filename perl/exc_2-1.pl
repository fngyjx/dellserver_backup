#!/usr/bin/perl
use warnings;
print;

print "Above is print, what warning yout got?\n";

3+4;

print "\nAbove is 3+4; what warning you got?\n";

print $n + 1;

print "\nAbove is \$n + 1; what warings you got?\n";
__END__

Useless use of a constant in void context at exc_2-1.pl line 7.
Name "main::n" used only once: possible typo at exc_2-1.pl line 11.
Use of uninitialized value in print at exc_2-1.pl line 3.
Above is print, what warning yout got?

Above is 3+4; what warning you got?
Use of uninitialized value in addition (+) at exc_2-1.pl line 11.
1
Above is $n + 1; what warings you got?

