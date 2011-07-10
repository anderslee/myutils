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

my @PRIORITY = qw(veryhigh high medium low verylow);
my @color = qw(red yellow green blue cyan);

my $options = {
        show_all => 0,
        help => 0,
};

use Getopt::Long;

GetOptions(
        "all|a" => \$options->{show_all},
        "help|h" => \$options->{help},
);

show_usage() if $options->{help};

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


        for my $id (sort keys %{$hashref->{notes}}) {
                # comment为done标志
                next if (defined $hashref->{notes}->{$id}->{done}
                                && !$options->{show_all});

                my $priority = $hashref->{notes}->{$id}->{priority};
                my $content = $hashref->{notes}->{$id}->{content};

                ### $priority
                ### $content

                printf ("%4d: ", $id);
                print color $color[$priority];
                print $content;

                print color 'reset';
                print "\n";
        }

        return;
}


sub show_usage {
        print <<"END_USAGE";
$0 [--all|-a]
-all|-a 打印所有事项，包括已经完成的
END_USAGE

        exit;
}
