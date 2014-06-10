package FullLoop;

use Moose;
use LWP;
use JSON::XS;

has 'config' => (
	is => 'rw',
	isa => 'FullLoop::Config'
);

1;