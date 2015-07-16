#!/bin/sh perl
=pod

=head1 Twitter Applicatoin Only Search API

=head2 Preparation

=over

=item Register on Twitter.com

=item Create customer_key and customer_secret

 For Application Only, the callback URL is not needed.

=back
=cut

use strict;
use warnings;
use LWP;
use Data::Dumper;

use JSON::XS;

use LWP::UserAgent;
my $ua = LWP::UserAgent->new;
$ua->agent("MyTwittApp/0.1 ");

my $customer_key="aXXXXXHB1CpR7jLHNnmvxg90e"; #Needs to be a valid twitter  customer_key
my $customer_secret="VQXXXXXYKXYGVFhHM1risNIl7Hk1DgMkvuiuYo1Finsq6FS3we"; #Needs to be a valid twitter customer_secret

use MIME::Base64 qw(encode_base64);

my $bear_token_credential=encode_base64($customer_key . ':' . $customer_secret);

# Create a access_token request
my $req = HTTP::Request->new(POST => 'https://api.twitter.com/oauth2/token');
$req->authorization('Basic ' . $bear_token_credential);
$req->content_type('application/x-www-form-urlencoded;charset=UTF-8');
$req->content('grant_type=client_credentials');

# Pass request to the user agent and get a response back

my $access_token;
my $res = $ua->request($req);

# Check the outcome of the response

#print Dumper($res);

if ($res->is_success) {

  my $res_content=JSON::XS->new->decode($res->content);

#  print Dumper($res_content);

  if ( $res_content->{'token_type'} eq 'bearer' ) {
        $access_token = $res_content->{'access_token'};
  } else {
        print STDERR "ERROR: the oauth2/token reponded was not a bearer access_token: " , Dumper($res_content) ,"\n";
        exit 2;
  }

} else {
        print $res->status_line, "\n";
        exit 1;
}

# Prepare Search request
my $search_req=HTTP::Request->new(GET => 'https://api.twitter.com/1.1/search/tweets.json?q=perl');
$search_req->authorization('Bearer ' . $access_token);
my $search_res_content;

#pass search request to browser and get the response
my $search_res=$ua->request($search_req);

if ($search_res->is_success) {

  $search_res_content=JSON::XS->new->decode($search_res->content);

#  print "search response : [", Dumper( $search_res_content), "]\n";

} else {
        print $search_res->status_line, "\n";
        print Dumper($search_req);
        exit 3;
}

use lib qw(./);
use Twitter::User;
use Twitter::Tweet;
my %user_tweet; #stores user's tweets

my %users; #stores users

my %tweets; #Stires tweets

#  print "search response : [", Dumper( $search_res_content), "]\n";
my $tweets=$search_res_content->{'statuses'};
#print "deref search_res_content'statuses'} [ ",Dumper($tweets), "]\n";
#print "tweetes [", @$tweets, "]\n";
foreach my $tweet (@$tweets) {
  my $t_tweet=Twitter::Tweet->new(
    id => $tweet->{'id'},
    lang => $tweet->{'lang'},
    user => $tweet->{'user'},
    text => $tweet->{'text'}
  ) || die "Failed : create tweet, $! \n";

  $tweets{$t_tweet->{id}}=$t_tweet;

#  print "$tweet [ ", Dumper($tweet),"]\n";
  my $user=$tweet->{'user'};
  my $user_id=$user->{'id'} || 9999999;
  my $user_lang=$user->{'lang'} || 'en';
  my $user_frndcnt=$user->{'friends_count'} || 0;
  if ( exists $user_tweet{$user_id} ) {
    push (@{$user_tweet{$user_id}}, $t_tweet);
  } else {
    $user_tweet{$user_id}=[ $t_tweet ];
  }

    my $t_user=Twitter::User->new(
    id => $user_id,
    friends_count => $user_frndcnt,
    contact => $user->{'name'}. ',' . $user->{'screen_name'} . ',' . $user->{'location'} ,
    tweets => $user_tweet{$user_id}
    ) || die "Failed create t_userm $! \n";
    $users{$user_id} = $t_user;
}

print "user_tweet : [", Dumper(\%user_tweet), "]\n";
print "users : [" , Dumper(\%users), "]\n";
__END__
$VAR1 = {
          'token_type' => 'bearer',
          'access_token' => 'AAAAAHkNeBd51H02mD9yP50H%2Fu%2F2kSe8%3DU1L16ArJIJmMPmHhMNePlmGOcsksAxnboOQzQs5sfKOrxTxk8T'
        };

=pod

=head1 Issuing application-only requests


=head2 Step 1: Encode consumer key and secret

The steps to encode an application’s consumer key and secret into a set of credentials to obtain a bearer token are:
1.URL encode the consumer key and the consumer secret according to RFC 1738. Note that at the time of writing, this will not actually change the consumer key and secret, but this step should still be performed in case the format of those values changes in the future.
2.Concatenate the encoded consumer key, a colon character “:”, and the encoded consumer secret into a single string.
3.Base64 encode the string from the previous step.

Below are example values showing the result of this algorithm. Note that the consumer secret used in this page has been disabled and will not work for real requests.

=over

=item Consumer key

oHB1CpR7jLHNnmvxg90e

=item Consumer secret

7YKXYGVFhHM1risNIl7Hk1DgMkvuiuYo1Finsq6FS3we

=back

RFC 1738 encoded consumer key (does not change) aHTFjoHB1CpR7jLHNnmvxg90e
RFC 1738 encoded consumer secret (does not change) YKXYGVFhHM1risNIl7Hk1DgMkvuiuYo1Finsq6FS3we
Bearer token credentials joHB1CpR7jLHNnmvxg90e:VQiwpr7YKXYGVFhHM1risNIl7Hk1DgMkvuiuYo1Finsq6FS3we
Base64 encoded bearer token credentials mpvSEIxQ3BSN2pMSE5ubXZ4ZzkwZTpWUWl3cHI3WUtYWUdWRmhITTFyaXNOSWw3SGsxRGdN
a3Z1aXVZbzFGaW5zcTZGUzN3ZQo=

=head2 Step 2: Obtain a bearer token

 The value calculated in step 1 must be exchanged for a bearer token by issuing a request to POST oauth2 / token:
 •The request must be a HTTP POST request.
 •The request must include an Authorization header with the value of Basic <base64 encoded value from step 1>.
 •The request must include a Content-Type header with the value of application/x-www-form-urlencoded;charset=UTF-8.
 •The body of the request must be grant_type=client_credentials.

 Example request (Authorization header has been wrapped):
 POST /oauth2/token HTTP/1.1
 Host: api.twitter.com
 User-Agent: My Twitter App v1.0.23
 Authorization: Basic  YEIxQ3BSN2pMSE5ubXZ4ZzkwZTpWUWl3cHI3WUtYWUdWRmhITTFyaXNOSWw3SGsxRGdN
 a3Z1aXVZbzFGaW5zcTZGUzN3ZQo=
                      Content-Type: application/x-www-form-urlencoded;charset=UTF-8
                      Content-Length: 29
                      Accept-Encoding: gzip

                      grant_type=client_credentials

If the request was formatted correctly, the server will respond with a JSON-encoded payload:

                      Example response:
                      HTTP/1.1 200 OK
                      Status: 200 OK
                      Content-Type: application/json; charset=utf-8
                      ...
                      Content-Encoding: gzip
                      Content-Length: 140

                      {"token_type":"bearer","access_token":"AAAAAAAAAAAAAAAAAAAAAAAA%2FAAAAAAAAAAAAAAAAAAAA%3DAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"}

Applications should verify that the value associated with the token_type key of the returned object is bearer. The value associated with the access_token key is the bearer token.

Note that one bearer token is valid for an application at a time. Issuing another request with the same credentials to /oauth2/token will return the same token until it is invalidated.

=head2 Step 3: Authenticate API requests with the bearer token

The bearer token may be used to issue requests to API endpoints which support application-only auth. To use the bearer token, construct a normal HTTPS request and include an Authorization header with the value of Bearer <base64 bearer token value from step 2>. Signing is not required.

Example request (Authorization header has been wrapped):
     GET /1.1/statuses/user_timeline.json?count=100&screen_name=twitterapi HTTP/1.1
     Host: api.twitter.com
     User-Agent: My Twitter App v1.0.23
     Authorization: Bearer AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA%2FAAAAAAAAAAAA
                            AAAAAAAA%3DAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
    Accept-Encoding: gzip

=head2 Invalidating a bearer token

Should a bearer token become compromised or need to be invalidated for any reason, issue a call to POST oauth2 / invalidate_token.

    Example request (Authorization header has been wrapped):
    POST /oauth2/invalidate_token HTTP/1.1
    Authorization: Basic eHZ6MWVFUFRHRUZQSEJvZzpMOHFxOVBaeVJn
                                                                 NmllS0dFS2hab2xHQzB2SldMdzhpRUo4OERSZHlPZw==
    User-Agent: My Twitter App v1.0.23
    Host: api.twitter.com
    Accept: */*
    Content-Length: 119
    Content-Type: application/x-www-form-urlencoded

    access_token=AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA%3DAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA

 Example response:
 HTTP/1.1 200 OK
 Content-Type: application/json; charset=utf-8
 Content-Length: 127
                                                 ...

 {"access_token":"AAAAAAAAAAAAAAAAAAAAAAAAAAA%2FAAAAAAAAAAAAAAAAAAAA%3DAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"}

=head2 Common error cases

 This section describes some common mistakes involved in the negotiation and use of bearer tokens. Be aware that not all possible error responses are covered here - be observant of unhandled error codes and responses!

 Invalid requests to obtain or revoke bearer tokens

 Attempts to:
 •Obtain a bearer token with an invalid request (for example, leaving out grant_type=client_credentials).
 •Obtain or revoke a bearer token with incorrect or expired app credentials.
 •Invalidate an incorrect or revoked bearer token.
 •Obtain a bearer token too frequently in a short period of time.

 Will result in:
 HTTP/1.1 403 Forbidden
 Content-Length: 105
 Content-Type: application/json; charset=utf-8
                                                                 ...

 {"errors":[{"code":99,"label":"authenticity_token_error","message":"Unable to verify your credentials"}]}

 API request contains invalid bearer token

 Using an incorrect or revoked bearer token to make API requests will result in:
 HTTP/1.1 401 Unauthorized
 Content-Type: application/json; charset=utf-8
 Content-Length: 61
 ...

 {"errors":[{"message":"Invalid or expired token","code":89}]}

 Bearer token used on endpoint which doesn’t support application-only auth

 Requesting an endpoint which requires a user context (such as statuses/home_timeline) with a bearer token will produce:
 HTTP/1.1 403 Forbidden
 Content-Type: application/json; charset=utf-8
 Content-Length: 91
                                                                 ...

 {"errors":[{"message":"Your credentials do not allow access to this res

=cut
