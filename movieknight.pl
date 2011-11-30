#!/usr/bin/perl -w

################################################################################
# Copyright (c) 2011, box2
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#    * Redistributions of source code must retain the above copyright
#      notice, this list of conditions and the following disclaimer.
#    * Redistributions in binary form must reproduce the above copyright
#      notice, this list of conditions and the following disclaimer in the
#      documentation and/or other materials provided with the distribution.
#    * Neither the name of the <organization> nor the
#      names of its contributors may be used to endorse or promote products
#      derived from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
# DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
################################################################################

use strict;
use Irssi;
use vars qw/$NAME $VERSION %IRSSI/;

$NAME = 'movieknight';
$VERSION = "0.01";
%IRSSI = (
	name            => $NAME,
	version         => $VERSION,
	author          => 'box2',
	contact         => 'haxnet irc',
	download        => 'tba',
	description     => 'loud and obnoxious alert when the knights are starting a public movie',
	license         => 'nouveau BSD',
);

my $ansi_map = {
	0 => 'white',
	1 => 'black',
	2 => 'blue',
	3 => 'green',
	4 => 'bold red',
	5 => 'red',
	6 => 'magenta',
	7 => 'yellow',
	8 => 'bold yellow',
	9 => 'bold green',
	10 => 'cyan',
	11 => 'bold cyan',
	12 => 'bold blue',
	13 => 'bold magenta',
	14 => 'bold black',
	15 => 'bold white',
};

sub cmd_movieknight {
	# data - user input after /cmd
	# server -the active server window
	# witem - the active window item (eg. channel, query)
	#	or undef if the window is empty
	my ($data, $server, $witem) = @_;

	if (!$server || !$server->{connected}) {
		Irssi::print("Not connected to server");
		return;
	}

	# We have data (movie title), we have an active chat window
	if ($data && $witem && ($witem->{type} eq "CHANNEL" || $witem->{type} eq "QUERY")) {
		$witem->command("MSG ".$witem->{name}." \0034/!\\ \0035RED ALERT \0034/!\\\0037 MOVIENIGHT IS STARTING \0034/!\\ \0035RED ALERT \0034/!\\");
		$witem->command("MSG ".$witem->{name}." NOW PLAYING: \037".$data);
	} else {
		Irssi::print("Usage: /mk <movie_title>");
	}
}

Irssi::command_bind('mk',	'cmd_movieknight');

