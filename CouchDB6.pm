class CouchDB {
use HTTP::UserAgent;

my $ua = HTTP::UserAgent.new;


has $url;

method request {
     my ($method, $uri, $content ) = @_;

    my $full_uri = $base_url ~ $uri;
    my $req;

    if ( defined $content ) {

        #Content-Type: application/json
        $req = HTTP::Request->new( $method, $full_uri, undef, $content );
        $req->header( 'Content-Type' => 'application/json' );
    }
    else {
        $req = HTTP::Request->new( $method, $full_uri );
    }

    my $response = $self->ua->request($req);

    if ( $response->is_success ) {
        return $response->content;
    }
    else {
        die( $response->status_line . ":" . $response->content );
    }
}

sub delete {
    my ( $self, $url ) = @_;

    $self->request( DELETE => $url );
}

sub get {
    my ( $self, $url ) = @_;

    $self->request( GET => $url );
}

sub put {
    my ( $self, $url, $json ) = @_;

    $self->request( PUT => $url, $json );
}

sub post {
    my ( $self, $url, $json ) = @_;

    $self->request( POST => $url, $json );
}

1;
