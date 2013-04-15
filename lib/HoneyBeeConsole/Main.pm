package HoneyBeeConsole::Main;
use Mojo::Base 'Mojolicious::Controller';

use lib 'lib';
use HoneyBeeConsole::Models::Model;

my $users = HoneyBeeConsole::Models::Model->new()->users;

sub login {
	my $self     = shift;
	my $login    = $self->param( 'login' );
	my $password = $self->param( 'password' ); 
	
	$self->app->log->info( "User with login: $login and password $password wants to log in." );	

	if ( defined( $login ) and defined( $password ) 
		and ( my $user = $users->login( $login, $password ) ) ) {		
		$self->session( user => $user);
		$self->render( text => "", status => 200 );
	}
	else {
		$self->render( text => "", status => 401 );
	}
}

sub logout {
	my $self = shift;
	$self->session( user => undef ) if $self->session( 'user' );
	$self->redirect_to('/');
}

sub index {
  my $self = shift;
  $self->render();
}

1;
