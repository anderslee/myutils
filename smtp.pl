#!/usr/bin/env perl 

#    Filename: 
#    Author: anders lee (jianghumanbu@gmail.com)
#    Date: 
#    Copyright: anders lee (jianghumanbu@gmail.com)

use strict;
use warnings;
use diagnostics;
use Modern::Perl;


use utf8;
binmode(STDOUT, ':encoding(utf8)');
binmode(STDIN, ':encoding(utf8)');
binmode(STDERR, ':encoding(utf8)');


use IO::Socket;
use Net::SMTP;
use Net::SMTP::SSL;
use Fcntl qw(:DEFAULT :flock);
use Posix qw(setsid);

my $log_file = shift @ARGV;

my @emails = (
        '13683358197@139.com',
        'jianghumanbu@gmail.com',
);


sub daemon
{
        my $child = fork();

        die "[EMERG] can't fork\n" unless defined $child;
        exit 0 if $child;

        setsid();

        open (STDIN, "</dev/null");
        open (STDOUT, ">/dev/null");
        open (STDERR, ">&STDOUT");

        chdir "/";

        umask(022);

        $ENV{PATH} = '/bin:/usr/bin/:/sbin:/usr/sbin';

        return $$;
}

sub write_log
{
        my $time = scalar localtime;

        open (HDW, ">>", $log_file);

        flock(HDW, LOCK_EX);
        say HDW $time, " ".join '', @_;
        flock(HDW, LOCK_UN);
        close HDW;
}


sub sendmail
{
        my $msg = shift;

        return unless @emails;

        my $smtp = Net::SMTP->new('Host'=> , 'Port' => 465);

        if (defined $smtp) {
                $smtp->mail("");
                $smtp->recipient(@emails);
                $smtp->data();
                $smtp->datasend("From:    \n");
                $smtp->datasend("To:      \n");
                $smtp->datasend("Subject: \n");
                $smtp->datasend("\n");

                for (@$msg) {
                        $smtp->datasend("$_\n");
                }

                $smtp->dataend();
                $smtp->quit();

        }
        else {
                warn("[WARN] Can't connect to SMTP host\n");
        }
}
