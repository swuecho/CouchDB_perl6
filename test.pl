use lib '.';
use CouchDB;
my $host = 'http://127.0.0.1:5984';
my $client = CouchDB.new( url => $host);
say $client.get('');
