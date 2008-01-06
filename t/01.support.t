use strict;
use Test::Base;
plan tests => 3 * blocks;

use HTTP::MobileAgent::Plugin::Location::Support;
use CGI;
local %ENV;

run {
    local %ENV;

    my $block = shift;
    my ($ua)                      = split(/\n/,$block->input);
    my ($area,$sector,$gps) = split(/\n/,$block->expected);

    $ENV{'HTTP_USER_AGENT'} = $ua;
    $ENV{'REQUEST_METHOD'}  = "GET";

    CGI::initialize_globals;

    my $ma = HTTP::MobileAgent->new;

    is $ma->support_area,   $area;
    is $ma->support_sector, $sector;
    is $ma->support_gps,    $gps;
};

__END__
=== 704i Test 1
--- input
DoCoMo/2.0 P704imyu(c100;TB;W30H15)
--- expected
1
1
0

=== 704i Test 2
--- input
DoCoMo/2.0 L704i(c100;TB;W24H14)
--- expected
1
1
0

=== 704i Test 3
--- input
DoCoMo/2.0 P704i(c100;TB;W24H12)
--- expected
1
1
0

=== 704i Test 4
--- input
DoCoMo/2.0 N704imyu(c100;TB;W24H12)
--- expected
1
1
0

=== 800i Test 1
--- input
DoCoMo/2.0 SA800i(c100;TB;W24H12)
--- expected
1
1
1

=== 800i Test 2
--- input
DoCoMo/2.0 D800iDS(c100;TB;W23H12)
--- expected
1
1
0

=== F883i Test 1
--- input
DoCoMo/2.0 F883i(c100;TB;W20H08)
--- expected
1
1
0

=== F883i Test 2
--- input
DoCoMo/2.0 F883iES(c100;TB;W20H08)
--- expected
1
1
1

=== Sector unsupported test: mova
--- input
DoCoMo/1.0/F505iGPS/c20/TB/W20H10
--- expected
1
0
1

=== Sector unsupported test: FOMA
--- input
DoCoMo/2.0 F2051(c100;TB)
--- expected
1
0
0
