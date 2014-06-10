#!/usr/bin/perl
use strict;
use warnings;
use Data::Dumper;
use FullLoop::Config;
use FullLoop::WUnderground::Radar;

my $cfg = new FullLoop::Config;

print Dumper($cfg->get('locations[1].label', 'XXX'));