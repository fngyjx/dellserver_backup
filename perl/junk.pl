#!/usr/bin/perl -w
while (<>)
{
chomp;
if (/my/)
{
print "Matched: |$`<$&>$'|\n";
}
}

@MA=qw(fred betty barney dino wilma pebbles bamm-bamm) ; 
#while (<STDIN>) {
#print "$MA[$_]\n";
#}


