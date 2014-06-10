package FullLoop::WUnderground::Radar;

use Moose;

extends 'FullLoop::WUnderground';


my $key_order = [
	'station',
	'brand',
	'num',
	'delay',
	'type',
	'frame',
	'scale',
	'noclutter',
	't',
	'lat',
	'lon',
	'label',
	'showstorms',
	'map.x',
	'map.y',
	'centerx',
	'centery',
	'transx',
	'transy',
	'showlabels',
	'severe',
	'rainsnow',
	'lightning',
	'smooth'
];

my $defaults = {
	'brand' => 'wui',
	'num' => 1,
	'delay' => 15,
	'frame' => 0,
	'scale' => 1.000,
	'noclutter' => 0,
	't' => 1318453547,
	'lat' => 0,
	'lon' => 0,
	'label' => 'you',
	'showstorms' => 1,
	'map.x' => 400,
	'map.y' => 240,
	'centerx' => 400,
	'centery' => 240,
	'transx' => 0,
	'transy' => 0,
	'showlabels' => 1,
	'severe' => 0,
	'rainsnow',1,
	'lightning' => 0,
	'smooth' => 1
};

has 'station' => (
	is => 'rw',
	isa => 'Str'
);

has 'type' => (
	is => 'rw',
	isa => 'Str'
);

sub pullRadar {
	my $timestamp = time();
	my %vals = %defaults;
	my %parameters = %{shift @_};
	my $name = shift @_;
	
	$vals{'t'} = $timestamp;
	$vals{'station'} = $parameters{'station'};
	$vals{'type'} = $parameters{'type'};

  my $url = '';
	foreach my $key (@key_order) {
		if (length($url) > 0) { $url .= '&'; } #amp;'; }
		$url .= $key . '=' . $vals{$key};
	}
	$url = 'http://radblast-mi.wunderground.com/cgi-bin/radar/WUNIDS_map?' . $url;

#  my $lead_in_image = ($IMAGE_BASE . 'misc/loop-lead-in.gif ') x 20;
#	my $dump_dir = $IMAGE_BASE . $name;
#	my $dump_path = $dump_dir . '/' . $timestamp . '.gif';
#	my $html_dir = $WWW_BASE . $name;
#	my $html_path = $html_dir . '/index.html';
#	
#	# make sure the image dumping directories exist
#	if (! -d $dump_dir) {
#		mkdir $dump_dir;
#		
#		if (! -d $dump_dir) {
#			print STDERR "Could not create $dump_dir\n";
#		} else {
#			if (! -d $dump_dir . '/animated') {
#				mkdir $dump_dir . '/animated';
#				if (! -d $dump_dir . '/animated') {
#					print STDERR "Could not create $dump_dir/animated\n";
#				}
#			}
#		}
#	}
#	
#	push @cities, $name;
#	
#	system "`which wget` -O $dump_path \"$url\"";
#	system "`which convert` -delay 10 -loop 0 `ls -l $lead_in_image $dump_dir/*.gif | awk \'{print \$9}\' | tail -n 36` $dump_dir/animated/radar.gif";
#	system "`which convert` -delay 10 -loop 0 `ls -l $lead_in_image $dump_dir/*.gif | awk \'{print \$9}\' | tail -n 144` $dump_dir/animated/historic.gif";
#	system "find $dump_dir -type f -mtime +10 -exec rm {} \\;";
#	
#	sleep 5;
}

1;