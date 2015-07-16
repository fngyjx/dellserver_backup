package Twitter::Tweet;

use Moo;
use namespace::clean;

has id => (
  is => 'ro',
  isa => sub {
        die "ERROR: Invalid id format!\n" unless ( $_[0] =~ m/[1-9][0-9]*/ ); #unless looks_like_number $_[0]
  }
);

has lang => (
  is => 'ro',
);

has user => (
  is => 'ro',
  isa => sub {
        die "ERROR: User contact is a required field and needs in hash format" unless ( $_[0] && ref($_[0]) eq 'HASH' )
  }
);

has text => (
  is => 'ro',
);

sub get {
  my $self = shift;
  my $field = shift || 'id';
  return $self->$field;
};

1;
