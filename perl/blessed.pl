package test_blesed

use Scalar::Util 'blessed';
my $foo = {};
my $bar = $foo;
bless $foo, 'String Class';
print blessed( $bar ),"\n";      # prints "Class"
$bar = "some other value";
print blessed( $bar ),"\n";      # prints undef

'String Class'->{my_obj_elem1}='test';
print 'String Class'->{my_obj_elem1},"\n";
print 'now object \'String Class\' is a hash data structure '. ref('String Class') ."\n";
#where ref('String Class') returns undef
print 'now object \'String Class\' is a hash data structure '. ref($foo) ."\n";
#where ref($foo) returns 'String Class'
print 'now object \'String Class\' is a hash data structure '. blessed($foo) ."\n";
#where blessed($foo) returns 'String Class'

sub print_blessed {
	my $self=shift;
	my $obj = shift;
	print 'bleseed : ' . blessed($obj);
}
