use WWW::Mechanize;
use LWP::UserAgent;

$ua = LWP::UserAgent->new;
$ua->agent("$0/0.1 " . $ua->agent);
#$ua->agent("Mozilla/8.0") # pretend we are very capable browser
$url = 'https://www.zhihu.com/question/24237220/'; 
$req = HTTP::Request->new(
   GET => 'https://validator.w3.org/nu/?doc=' . $url . '&out=json');
#$req->header('Accept' => 'text/html');
$req->header('content-type' => 'application/json');
 
# send request
$res = $ua->request($req);
#print $res->decoded_content;
#$str = "\"messages\":[{\"type\":\"error\",\"lastLine\":2,\"";
$str = $res->decoded_content;
$error = ($str =~ s/\"type\":\"error\"/\"type\":\"error\"/g);
$warning = ($str =~ s/\"subType\":\"warning\"/\"subType\":\"warning\"/g);  
printf "errors: %s, warnings: %s\n",$error,$warning;

