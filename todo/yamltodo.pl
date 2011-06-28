#!/usr/bin/perl 
#===============================================================================
#
#         FILE:  yamltodo.pl
#
#        USAGE:  ./yamltodo.pl  
#
#  DESCRIPTION:  yaml todo
#
#      OPTIONS:  ---
# REQUIREMENTS:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  anderslee (Anders Lee), anderslee@yeah.net
#      COMPANY:  just for fun
#      VERSION:  1.0
#      CREATED:  06/25/2011 12:43:45 PM
#     REVISION:  ---
#===============================================================================

use strict;
use warnings;
use diagnostics;
use Modern::Perl;

use utf8;
binmode(STDOUT, ':encoding(utf8)');


use YAML::Tiny;

#use Data::Dumper qw(Dumper);

my $yaml = YAML::Tiny->read('.todo');

#say Dumper $yaml->[1]->{note}->[0];

todo_print($yaml);

#######################################################################

sub todo_print
{
        my ($yaml) = @_;

        for my $note (@{$yaml->[1]->{note}}) {
                printf "%4d: %s\n", $note->{id}, $note->{content};
        }
        return;
}
