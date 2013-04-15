package HoneyBeeConsole::Admin;
use Mojo::Base 'Mojolicious::Controller';

use lib 'lib';
use HoneyBeeConsole::Models::Model;

my $model = HoneyBeeConsole::Models::Model->new();

sub register_user {
	my $self = shift;
	
	unless ( $self->session( 'user' ) ) {
		$self->redirect_to('/');
		return;
	}

	my $login = $self->param( 'login' );
	my $password =  $self->param( 'password' ); 

	$self->app->log->info( "User with login: $login and password $password will be registered." );

	if ( defined( $login ) and defined( $password ) and $model->users->register( $login, $password ) ) {
		$self->render( text => "", status => 201 );
	}
	else {
		$self->render( text => "User has already been registered", status => 409 );
	}
}

1;
