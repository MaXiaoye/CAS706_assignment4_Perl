use WWW::Mechanize;
use LWP::UserAgent;

# Search keyword as input
print "Please input keyword for searching: ";
my $word = <STDIN>;
# Pages
my $page = 1;
print "Start\n";

for ($i = 0; $i < $page; $i = $i + 1) {
	# url of result page 
	my $url = 'http://www.baidu.com/s?wd=' . $word . '&pn=' . $i; 
	# New Mechanize Html parser
	my $mech = WWW::Mechanize->new();
	# Get html of result page
	$mech->get( $url );
	# Get result links
	my @links = $mech->find_all_links( url_regex => qr/link/i );
	
	# For each link, send it to w3c validator.
	for my $link ( @links ) {
		# Send http 'get' request by using www library
		$ua = LWP::UserAgent->new;
		$ua->agent("$0/0.1 " . $ua->agent);
		$url = $link->url; 
		$req = HTTP::Request->new(
		   GET => 'https://validator.w3.org/nu/?doc=' . $url . '&out=json');
		$req->header('content-type' => 'application/json');
		
		# Get result 
		$res = $ua->request($req);
		$str = $res->decoded_content;
		
		# Collect errors and warnings
		$error = ($str =~ s/\"type\":\"error\"/\"type\":\"error\"/g);
		$warning = ($str =~ s/\"subType\":\"warning\"/\"subType\":\"warning\"/g);  
		printf "link: %s, errors: %s, warnings: %s\n",$url,$error,$warning;
	}
}

print "End!";