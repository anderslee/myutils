#!/usr/bin/perl 
#===============================================================================
#
#         FILE:  echo2.pl
#
#        USAGE:  ./echo2.pl  
#
#  DESCRIPTION:  echo use POE
#
#      OPTIONS:  ---
# REQUIREMENTS:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  anderslee (Anders Lee), anderslee@yeah.net
#      COMPANY:  just for fun
#      VERSION:  1.0
#      CREATED:  06/27/2011 09:31:20 PM
#     REVISION:  ---
#===============================================================================

use strict;
use warnings;
use diagnostics;
use Modern::Perl;


use IO::Socket;

use POE;
use POE::Wheel::ListenAccept;
use POE::Wheel::ReadWrite;

# start the server session

POE::Session->create (
        inline_states => {
                _start => \&server_start,
                server_accepted => \&server_accepted,
                server_error => \&server_error,
                client_input => \&client_input,
                client_error => \&client_error,
        },
);


POE::Kernel->run();

exit;

sub server_start {
        my $server = IO::Socket::INET->new(
                LocalPort => 12345,
                Listen => 10,
                Reuse => "yes",
        ) or die "can't make server socket: $@\n";

        $_[HEAP]->{server} = POE::Wheel::ListenAccept->new (
                Handle => $server,
                AcceptEvent => "server_accepted",
                ErrorEvent => "server_error",
        );
        return;
}

# handle new connections from the ListenAccept wheel.
# create wheels to interact with them.
# store them by each wheel's unique ID \
# so they don't clobber  each other.


sub server_accepted {
        my $client = $_[ARG0];

        my $wheel = POE::Wheel::ReadWrite->new(
                Handle => $client,
                InputEvent => "client_input",
                ErrorEvent => "client_error",
        );

        $_[HEAP]->{client}->{$wheel->ID()} = $wheel;
        return;
}


# handle input from ReadWrite wheel.

sub client_input {
        my ($heap, $input, $wheel_id) = @_[HEAP, ARG0, ARG1];

        $heap->{client}->{$wheel_id}->put($input);

        return;
}

sub client_error {
        my ($heap, $wheel_id) = @_[HEAP, ARG3];
        delete $heap->{client}->{$wheel_id};

        return;
}

sub server_error {
        delete $_[HEAP]->{server};
}
