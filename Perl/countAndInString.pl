#!/usr/bin/env perl
use strict;
use warnings;

print STDOUT "Give an string, you will get the numbers of 'and' in the string : ";

my $input_string = <>;

print "the input is : " .  $input_string ,"\n";

my $count = $input_string =~ s/and/and/g;

print "There are $count 'and' the input string \n";

