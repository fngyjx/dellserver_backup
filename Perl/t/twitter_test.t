use strict;
use Test::Simple tests => 3;

use lib qw( ./ );

use Twitter::User;
use Twitter::Tweet;

my $t_tweet=Twitter::Tweet->new(
  id => 123,
  lang => 'en',
  user => { id => 2345, name => "Twitter User" },
  text => 'I am implementing search tool in perl'
);

ok( defined $t_tweet && ref $t_tweet eq 'Twitter::Tweet', 'The tweet obj is created');

my $t_user=Twitter::User->new(
  id => 2345,
  friends_count => 123,
  contact => 'john.doe@twitter.com',
  tweets => [$t_tweet]
);

ok($t_user->{friends_count} > 100, 'There are enough friends');

ok($t_tweet->{lang} =~ /en/,'The message has to be in English');
