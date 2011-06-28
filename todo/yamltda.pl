#!/usr/bin/perl 
#===============================================================================
#
#         FILE:  yamltda.pl
#
#        USAGE:  ./yamltda.pl  
#
#  DESCRIPTION:  yaml tda
#
#      OPTIONS:  ---
# REQUIREMENTS:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  anderslee (Anders Lee), anderslee@yeah.net
#      COMPANY:  just for fun
#      VERSION:  1.0
#      CREATED:  06/25/2011 12:16:23 PM
#     REVISION:  ---
#===============================================================================

use strict;
use warnings;
use diagnostics;

use utf8;
binmode(STDOUT, ':encoding(utf8)');
binmode(STDIN, ':encoding(utf8)');

use Modern::Perl;
use YAML qw(DumpFile LoadFile);

use local::lib;

my $VERSION = '0.1.20';

my @PRIORITY = qw(sys veryhigh high medium low verylow);

#use My::YAML::Tiny;


init_todo(my_readline()) unless -f '.todo';

todo_write(my_readline());

#######################################################################

sub my_readline {
        my $content;
        my $priority;

        use Term::ReadLine;
        my $term = Term::ReadLine->new('todo');
        my $OUT = $term->OUT() || \*STDOUT;

        say "请输入要完成的事项, 要退出请输入q";

        CONTENT: while (defined($_ = $term->readline('text: '))) {
                exit if /^q$/;
                redo CONTENT unless /\S/;
                $content = $_;
                last CONTENT;
                #$term->addhistory($_);
        }

        say "请输入优先级数字";

        PRIORITY: while (defined($_ = $term->readline('priority'))) {
                redo PRIORITY unless /\d/;
                $priority = $_;
                last PRIORITY;
        }

        return ($content, $priority);
}

sub todo_write
{
        my ($content, $priority) = @_;
        my $time = time;

        my ($string, $arrayref) = LoadFile('.todo');
        
        my $note = {
                id => $#$arrayref,
                priority => $PRIORITY[$priority],
                time => $time,
                content => $content,
        };


        push @$arrayref, $note;
        DumpFile('.todo', $string, $arrayref);
}

sub init_todo
{
        my ($content, $priority) = @_;
        my $time = time;
        my $notes = {};

        $notes->{todo} = $VERSION;
        $notes->{note} = [];
        my $note = {
                id => 1,
                priority => $PRIORITY[$priority],
                time => $time,
                content => $content,
        };

        push @{$notes->{note}}, $note;

        my $todo_file = '.todo';

        DumpFile($todo_file, $notes->{todo}, $notes->{note});

        chmod 0600, $todo_file;

        return;
}
