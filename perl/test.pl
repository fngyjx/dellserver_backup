#!/bin/sh perl
use strict;
use warnings;
use Data::Dumper;
use my_blessed;

my $obj=my_blessed->print_blessed();

my %hash;
for my $id ( 1,2,3,1,2) {
	if ( exists $hash{$id} ) {
		push(@{$hash{$id}},"myTest".$id);
	} else {

		$hash{$id} = [ "MyTest".$id ];
	}
}
print Dumper(\%hash); 
