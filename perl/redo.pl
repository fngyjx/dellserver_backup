#!/usr/bin/perl -w
use strict;
my @words=qw{fred barney pebbles dino wilma betty};

foreach (@words){
###redo comes here
print "Type the word $_ :";
chomp ( my $try=<STDIN> );
unless ($try eq $_) {
	print "Sorry - That's not right.\n\n";
	redo;
	}
	}

