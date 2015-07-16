#!/usr/bin/env perl
use strict;
use warnings;

sub log10 {
	my $n = shift;
	return log($n)/log(10);
}

print STDOUT "Give an integer, you will have an array of its digits: ";

my $input_digit = <>;

print "the input is : " .  $input_digit;
my $in_log=log10($input_digit);
$in_log=int($in_log);
my @out_array;
for ( my $n=$in_log; $n>=0; $n-- ) {
	my $lead_char=int($input_digit/(10**$n));
	$input_digit%=(10**$n);
	push @out_array,$lead_char;
}
print STDOUT 'The return digit array is: ['. join(',',@out_array) . "]\n";

