#!/usr/bin/perl -w
print " what is your name? \n";
my $name=<STDIN>;
print " I've never met someone named $name before\n";

print "Please give another name\n";
if ( ($line = <STDIN>) ne "\n" ) {
 print "the input line was : $line";
 }

 $betty=chomp $line;
 print "The line chmped $betty charctors and now the new line looked as: \n $line";

print "use chomp instead of old chop becuase the chop removes any trailing charactor but chomp only removes the trailing new line charactor\n";

$betty_2=chomp $line;
print "chomp removed $betty_2 charator and the line is now looked as:\n $line\n";

$betty_3=chop $line;
print "chop removed $betty_3 charactor and the line is looked as:\n $line\n";

