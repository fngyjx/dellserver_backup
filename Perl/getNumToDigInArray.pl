#!/usr/bin/env perl
use strict;
use warnings;

print STDOUT "Give an integer, you will have an array of its digits: ";

my $input_digit = <>;

print "the input is : " .  $input_digit;
my $temp_digit=$input_digit;
my @out_array;
my $mod=1;
while ( $temp_digit > 0 ) {
	my $mod=1;
	while ( $temp_digit > 10 ) {
		$temp_digit = int($temp_digit*0.1);
		$mod *= 10;
	}
	push @out_array, $temp_digit;
	$input_digit -= $temp_digit*$mod;
	$temp_digit=$input_digit;
}
print STDOUT 'The return digit array is: ['. shift(@out_array);
foreach (@out_array) {
	print STDOUT ",".$_;
}
print STDOUT "]\n";

