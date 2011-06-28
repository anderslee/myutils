#!/usr/bin/perl 
#===============================================================================
#
#         FILE:  echo_client.pl
#
#        USAGE:  ./echo_client.pl  
#
#  DESCRIPTION:  use POE::Component::Client::TCP
#
#      OPTIONS:  ---
# REQUIREMENTS:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  anderslee (Anders Lee), anderslee@yeah.net
#      COMPANY:  just for fun
#      VERSION:  1.0
#      CREATED:  06/27/2011 09:53:02 PM
#     REVISION:  ---
#===============================================================================

use strict;
use warnings;
use diagnostics;
use Modern::Perl;


use POE;
use POE::Component::Client::TCP;

POE::Component::Client::TCP->new(
        RemoteAddress => 'localhost',
        RemotePort => 12345,
        Connected => sub {
                $_[HEAP]{server}->put("Head /");
        },
        ServerInput => sub {
                my $input = $_[ARG0];
                print "from server: $input\n";
        },
);

POE::Kernel->run();
exit;
