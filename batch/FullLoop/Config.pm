package FullLoop::Config;

use strict;
use warnings;
use Moose;
use Data::Dumper;
use Getopt::Long;
use File::Slurp;
use JSON::XS;

my $config_file = 'config.json';
GetOptions("config=s" => \$config_file) or die("Error in command line arguments\n");

my $cfg_data = {};

sub BUILD {
	my $self = shift @_;
	if (-e $config_file) {
		my $data = read_file($config_file);
		$cfg_data = decode_json($data);
	}
}

sub get {
	my $self = shift;
	my $key = shift @_;
	my $default = shift @_ || undef;
	
	print "$key - ";
	$key =~ s/\[([^\]]+)\](\.|$)/\.$1$2/g;
	print "$key\n";
	
	if ($key =~ m/[\[\]]/) {
		die "Invalid key syntax in FullLoop::Config->get(\"$key\")\n";
	}
	
	
	my @keys = ();
	
	@keys = split(/\./, $key);
	my $node = $cfg_data;
	my $next_key = shift @keys;
	while (defined $next_key && ((ref($node) eq 'HASH' && $node->{$next_key}) || (ref($node) eq 'ARRAY' && $next_key =~ m/^\d+$/ && $node->[$next_key]))) {
		$node = ref($node) eq 'HASH' ? $node->{$next_key} : $node->[$next_key];
		$next_key = scalar @keys > 0 ? shift @keys : undef;
	}
				 
	return defined $next_key ? $default : $node;
}

1;