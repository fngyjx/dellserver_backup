package Twitter::User;

use Moose;
use namespace::clean;

has id => (
  is => 'ro',
  isa => 'Int'
);

has lang => (
  is => 'ro',
  isa => 'String'
);

has contact => (
  is => 'rw'
);

has tweets => (
  is => 'rw',
  isa => 'ArrayRef'
);

has friends_count => (
  is => 'rw',
  isa => 'Int'
);

sub get {
  my $self = shift;
  my $field = shift || 'id';
  return $self->$field;
}

sub update {
  my $self = shift;
  my $field = shift;
  my $value = shift || 0;
    $self->$field = $value;
}

1;
