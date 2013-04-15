package HoneyBeeConsole::Banners;
use Mojo::Base 'Mojolicious::Controller';

use Data::Dumper;

use lib 'lib';
use HoneyBeeConsole::Models::Model;
use HoneyBeeConsole::Models::Banners;

my $banners = HoneyBeeConsole::Models::Model->new->banners;

sub index {
	my $self = shift;
	
	unless ( $self->session( 'user' ) ) {
		$self->redirect_to( '/' );
	} else {
		my $user_id = $self->session( 'user' )->{ _id }->{ '$oid' };
  		$self->render({ banners => $banners->load_for_user( $user_id ) });
  	}
}

1;