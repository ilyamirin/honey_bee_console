package HoneyBeeConsole::Models::Model;

use Modern::Perl;
use MongoDB::MongoClient;
use MongoDB::Database;
use MongoDB::Collection;
use HoneyBeeConsole::Models::UsersModel;
use HoneyBeeConsole::Models::Banners;

my $client = MongoDB::MongoClient->new;
my $db = $client->get_database( 'cap' );
my $users = $db->get_collection( 'users' );
my $banners = $db->get_collection( 'banners' );

sub new { bless {}, shift }

sub users {
	my $self = shift;
	my $users_model = HoneyBeeConsole::Models::UsersModel->new({ users => $users });
	return $users_model;
}

sub banners {
	my $self = shift;
	return HoneyBeeConsole::Models::Banners->new({ collection => $banners });
}

1;