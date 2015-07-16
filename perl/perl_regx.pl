#!/usr/bin/perl -w
while (<>)
{
chomp;
if (/((fred|silma) (flintstone)) \1/)
{
print "\(\(fred|silma\) \(flintstone\)\) \\1\n";
print "Matched: |$`<$&>$'|\n";
}
elsif (m{((fred|silma) (flintstone)) \2})
{
print "\(\(fred|silma\) \(flintstone\)\) \\2\n";
print "Matched: |$`<$&>$'|\n";
}
elsif (m!((fred|silma) (flintstone)) \3!)
{
print "\(\(fred|silma\) \(flintstone\)\) \\3\n";
print "Matched: |$`<$&>$'|\n";
}
}
__END__
[zhong@localhost perl]$ perl perl_regx.pl
silma flintstone silma flintstone
((fred|silma) (flintstone)) \1
Matched: |<silma flintstone silma flintstone>|
silma filintstone silma
silma flintstone silma
((fred|silma) (flintstone)) \2
Matched: |<silma flintstone silma>|
silma flintstone flintstone
((fred|silma) (flintstone)) \3
Matched: |<silma flintstone flintstone>|

Name "main::MA" used only once: possible typo at perl_regx.pl line 22.
my fred flintstone wilma flintstone
your fred flintstone fred
((fred|silma) (flintstone)) \2
Matched: |your <fred flintstone fred>|
their wilma flintstone flintstone
their silma flintsone flintstone
their fred flintstone flintstone
((fred|silma) (flintstone)) \3
Matched: |their <fred flintstone flintstone>|
fred flintstone fred flintstone
((fred|silma) (flintstone)) \1
Matched: |<fred flintstone fred flintstone>|

@MA=qw(fred betty barney dino wilma pebbles bamm-bamm) ; 
#while (<STDIN>) {
#print "$MA[$_]\n";
#}


