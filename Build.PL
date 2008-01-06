use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'HTTP::MobileAgent::Plugin::Location',
    license             => 'perl',
    dist_author         => 'OHTSUKA Ko-hei <nene@kokogiko.net>',
    dist_version_from   => 'lib/HTTP/MobileAgent/Plugin/Location.pm',
    requires => {
        'Test::Base'                       => 0,
        'version'                          => 0,
        'CGI'                              => 0,
        'Class::Data::Inheritable'         => 0,
        'Class::Accessor::Fast'            => 0,
        'HTTP::MobileAgent::Plugin::XHTML' => 0,
        'URI'                              => 0,
        'URI::QueryParam'                  => 0,
        'URI::Escape'                      => 0,
    },
    auto_features => {
        'Location::GeoTool'           => {
            description => "Use location object as Location::GeoTool",
            requires    => { 
                'Location::GeoTool'             => 2,
            },
        },
        'Geo::Coordinates::Converter' => {
            description => "Use location object as Geo::Coordinates::Converter",
            requires    => {
                'Geo::Coordinates::Converter'   => 0,
            },
        },
        'i-Area'                      => {
            description => "Use i-Area object",
            requires    => {
                'Location::Area::DoCoMo::iArea' => 2.1,
            },
        },
    },
    add_to_cleanup      => [ 'HTTP-MobileAgent-Plugin-Location-*' ],
);

$builder->create_build_script();
