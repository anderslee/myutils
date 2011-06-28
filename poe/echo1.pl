#!/usr/bin/perl 
#===============================================================================
#
#         FILE:  echo1.pl
#
#        USAGE:  ./echo1.pl  
#
#  DESCRIPTION:  echo use IO::Socket
#
#      OPTIONS:  ---
# REQUIREMENTS:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  anderslee (Anders Lee), anderslee@yeah.net
#      COMPANY:  just for fun
#      VERSION:  1.0
#      CREATED:  06/27/2011 08:04:36 PM
#     REVISION:  ---
#===============================================================================

use strict;
use warnings;
use diagnostics;
use Modern::Perl;


use POSIX;
use IO::Select;
use IO::Socket;
use Tie::RefHash;

my $server = IO::Socket::INET->new(
        LocalPort => 12345,
        Listen => 10,
) or die "can't make server socket: $@\n";

$server->blocking(0);

my %inbuffer = ();
my %outbuffer = ();

my %ready = ();

tie %ready, "Tie::RefHash";


my $select = IO::Select->new($server);

while (1) {
        for my $client ($select->can_read(1)) {
                handle_read($client);
        }

        for my $client (keys %ready) {
                for my $request (@{$ready{$client}}) {
                        print "Got request: $request";
                        $outbuffer{$client} .= $request;
                }
                delete $ready{$client};

        }

        for my $client ($select->can_write(1)) {
                handle_write($client);
        }
}

exit;

sub handle_read {
        my $client = shift;

        # If it's the server socket, accept a new client connection
        if ($client == $server) {
                my $new_client = $server->accept();

                $new_client->blocking(0);

                $select->add($new_client);

                return;
        }
        # read from an established client socket
        my $data = "";

        my $rv = $client->recv($data, POSIX::BUFSIZ, 0);

        # handle socket errors
        unless (defined($rv) and length($data)) {
                handle_error($client);
                return;
        }

        $inbuffer{$client} .= $data;

        while ($inbuffer{$client} =~ s/(.*\n)//) {
                push @{$ready{$client}}, $1;
        }

}


sub handle_write {
        my $client = shift;

        return unless exists $outbuffer{$client};

        my $rv = $client->send($outbuffer{$client}, 0);
        unless (defined $rv) {
                warn "I was told I could write, but I can't.\n";
                return;
        }

        if ($rv == length($outbuffer{$client}) ||
                $! == POSIX::EWOULDBLOCK) {
                        substr ($outbuffer{$client}, 0, $rv) = "";
                        delete $outbuffer{$client}
                                unless length $outbuffer{$client};
                        return;
        }

        # otherwise

        handle_error($client);
}

sub handle_error {
        my $client = shift;

        delete $inbuffer{$client};
        delete $outbuffer{$client};
        delete $ready{$client};

        $select->remove($client);

        close $client;
}

