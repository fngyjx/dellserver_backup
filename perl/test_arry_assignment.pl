#!/usr/bin/perl -w
#use strict;

my @new_arry=(99_900..99_999);
print "@new_arry\n";
 my @nums=(3,5,9,2,7); 
 my $i=42;

 foreach $i (@nums) {
 $i *= 10;
 print "Now \$i = $i\n";
 }

print "it is now @nums and \$i=$i\n";

my $a=@nums;
my $b= sort @nums;

print "\$a= $a; \$b=$b\n";
