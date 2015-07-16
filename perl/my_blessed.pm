package my_blesed;

use Scalar::Util 'blessed';
my $foo = {};
my $bar = $foo;

'Class'->{my_obj_elem0}='test';
bless $foo, 'Class';
print blessed( $bar ),"\n";      # prints "Class"
$bar = "some other value";
print blessed( $bar ),"\n";      # prints undef

'Class'->{my_obj_elem1}='test';
print 'Class'->{my_obj_elem1},"\n";
print 'now object \'Class\' is a hash data structure '. ref('Class') ."\n";
#where ref('String Class') returns undef
print 'now object \'Class\' is a hash data structure '. ref($foo) ."\n";
#where ref($foo) returns 'String Class'
print 'now object \'Class\' is a hash data structure '. blessed($foo) ."\n";
#where blessed($foo) returns 'String Class'

sub print_blessed {
	my $class=shift;
	print 'bleseed : ' . blessed($obj) . "\n";
	my $self={};
	bless $self, $class;
	return $self;
}
