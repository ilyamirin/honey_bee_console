package HoneyBeeConsole;
use Mojo::Base 'Mojolicious';

# This method will run once at server start
sub startup {
  my $self = shift;

  # Documentation browser under "/perldoc"
  $self->plugin('PODRenderer');

  # Router
  my $r = $self->routes;

  # Normal route to controller
  $r->get('/')->to('main#index');

  $r->post('/login')->to('main#login');
  $r->get('/logout')->to('main#logout');

  #private zone
  $r->get('/banners')->to('banners#index');

  #admin zone
  $r->post('/admin/user/#login/#password')->to('admin#register_user');  
}

1;
