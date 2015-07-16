#!/usr/bin/env perl
use strict;
use warnings;

print STDOUT "Give a List, then its palindrome list will be returned: ";

my $in_list;
foreach (@ARGV) {
	$in_list .= $_;
}
print "\nthe input is : $in_list\n";
$in_list =~ s/\[//g;
$in_list =~ s/\]//g;
my @out_array=split(',',$in_list);

push @out_array,reverse(@out_array);
print STDOUT 'The slindrome list is : [' . join(',',@out_array), "]\n";

