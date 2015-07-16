#!/usr/bin/perl -w
package main;
   local $x = 10; #Global/Dynamic/Package $x
   my    $x = 20; #Local/Lexical/static $x

   print "$x and $::x\n";
#20 and 10
# my $pack::var;      # ERROR!  Illegal syntax cannot make package variable lexical
# my $_;              # also illegal (currently) cannot make global variable lexical

