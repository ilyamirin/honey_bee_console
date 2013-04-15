package HoneyBeeConsole::Models::TargetModel;

use Modern::Perl;
use MongoDB::OID;

sub new { 
	my $class = shift;
	my $self = shift;
	bless $self, $class;
}

sub create {
	my ( $self, $name, $banners ) = @_;
	return 0 if $self->{ targets }->find_one({ login => $login });
	return 1;
}

sub update {

}

sub remove {
	
}

sub add_bunner {

}

sub remove_banner {

}

sub update_bunner {

}

1;