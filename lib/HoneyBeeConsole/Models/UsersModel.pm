package HoneyBeeConsole::Models::UsersModel;

use Modern::Perl;
use MongoDB::OID;
use Digest::MD5;

sub new { 
	my $class = shift;
	my $self = shift;
	bless $self, $class;
}

sub init_hasher {
	my $self = shift;
	$self->{ hasher } = Digest::MD5->new;
}

sub register {
	my ( $self, $login, $pass ) = @_;
	return 0 if $self->{ users }->find_one({ login => $login });
	$self->init_hasher;
	$self->{ hasher }->add( $login, $pass );
	my $pass_hash = $self->{ hasher }->b64digest();	
	$self->{ users }->insert({ login => $login, pass_hash => $pass_hash });
}

sub login {
	my ( $self, $login, $pass ) = @_;

	my $user = $self->{ users }->find_one({ login => $login }) or return 0;

	$self->init_hasher();
	$self->{ hasher }->add( $login, $pass );
	my $pass_hash = $self->{ hasher }->b64digest();

	return $user->{ pass_hash } eq $pass_hash ? $user : undef;
}

1;