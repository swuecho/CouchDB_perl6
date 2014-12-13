use HTTP::UserAgent;
use HTTP::Request;
# use can not be used in class definition
class CouchDB {

has $.ua =  HTTP::UserAgent.new ;

has $.url;

method request($method, $url, $content?) {

    my $full_uri = $.url ~ $url;
    say $full_uri;
    return $full_uri;
    my $req;

    if ( defined $content ) {
        #Content-Type: application/json
        $req = HTTP::Request.new( $method, $full_uri,'Content-Type' => 'application/json' , 'Content'=> $content );
    }
    else {
        say $full_uri;
        #$req = HTTP::Request.new( $method => $full_uri );
    }

    my $response = $.ua.request($req);

    if ( $response.is_success ) {
        return $response.content;
    }
    else {
        die( $response.status_line ~ ":" ~ $response.content );
    }
}

method get($url) {
   $.ua.get($.url ~ $url);
}

method delete($url) {
    self.request( DELETE => $url );
}


method put($url, $json) {
    self.request( PUT => $url, $json );
}

method post($url, $json) {
    self.request( POST => $url, $json );
}

}

