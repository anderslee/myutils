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
#use Smart::Comments;

use Term::ANSIColor;

my $VERSION = '0.1.20';

use Storable;

my $todo_file = '.todo';

unless (-f $todo_file) {
        say "$todo_file not exists, please use perltda to create one";
        exit;
}

#use Data::Dumper qw(Dumper);

#say Dumper $yaml->[1]->{note}->[0];

todo_print($todo_file);

#######################################################################

sub todo_print
{
        my ($todo_file) = @_;

        my $hashref = retrieve $todo_file;


        my %color = (
                veryhigh => 'red',
                high => 'yellow',
                medium => 'green',
                low => 'blue',
                verylow => 'cyan',
        );

        for my $id (sort keys %{$hashref->{notes}}) {
                # comment为done标志
                next if defined $hashref->{notes}->{$id}->{done};

                my $priority = $hashref->{notes}->{$id}->{priority};
                my $content = $hashref->{notes}->{$id}->{content};

                ### $priority
                ### $content

                printf ("%4d: ", $id);
                print color $color{$priority};
                print $content;

                print color 'reset';
                print "\n";
        }

        return;
}
