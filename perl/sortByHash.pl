#!/usr/bin/perl -w
my %score=("barney" => 195, "fred" => 205, "dino" => 30);
my @winners= sort by_score keys %score;
print "@winners \n";
@winners= sort by_score_arc keys %score;
print "@winners \n";
@winners= sort by_score_ars keys %score;
print "@winners \n";
@winners= sort by_score_ars_dec keys %score;
print "@winners \n";

$score{"bamm-bamm"}=195;
@winners=sort by_score_and_key keys %score;
print "@winners \n";

sub by_score_and_key {
$score{$a} <=> $score{$b} or $a cmp $b;
}
sub by_score {
$score{$b} <=> $score{$a};
}
sub by_score_arc {
$score{$a} <=> $score{$b};
}
sub by_score_ars {
$a cmp $b;
}
sub by_score_ars_dec {
$b cmp $a;
}
