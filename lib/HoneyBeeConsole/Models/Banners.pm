package HoneyBeeConsole::Models::Banners;

use Modern::Perl;
use MongoDB::OID;
use Data::Dumper;

sub new { 
	my ( $class, $self ) = @_;
	bless $self, $class;
}

sub load_for_user {
	my $self = shift;
	my $user_oid = MongoDB::OID->new( value => shift );
	return [ $self->{ collection }->find({ user =>  $user_oid })->all ];
}

sub insert {
	my ( $self, $title, $picture, $size ) = @_;
	my $coll = $self->{ collection };	
	$coll->insert({ title => $title, picture => $picture, size => $size });
}

sub update {
	my ( $self, $id, $title, $picture, $size ) = @_;
	my $mongo_id = MongoDB::OID->new({ value => $id });
	my $coll = $self->{ collection };	
	$coll->update({ _id => $mongo_id }, { title => $title, picture => $picture, size => $size }, { safe => 1 });	
}

sub get {
	my ( $self, $id ) = @_;
	my $mongo_id = MongoDB::OID->new({ value => $id });
	$self->{ collection }->find_one({ _id => $mongo_id });
}

sub get_few {
	my ( $self, $ids ) = @_;
	
	return [ ] unless ref( $ids ) eq 'ARRAY';

	my @mongo_ids = ( );
	push @mongo_ids, MongoDB::OID->new({ value => $_ }) for @$ids;

	$self->{ collection }->find({ _id => { '$in' => @mongo_ids } });
}

1;