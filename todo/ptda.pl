#!/usr/bin/perl 
#===============================================================================
#
#         FILE:  yamltda.pl
#
#        USAGE:  ./yamltda.pl  
#
#  DESCRIPTION: tda built on perl
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
binmode(STDIN, ':encoding(utf8)');
binmode(STDOUT, ':encoding(utf8)');

use Modern::Perl;

use Storable;
#use DBM::Deep;

#use Smart::Comments;

#use local::lib;

my $VERSION = '0.1.20';

my @PRIORITY = qw(veryhigh high medium low verylow);
my @color = qw(red yellow green blue cyan);

unless (-f '.todo') {
        todo_init(my_readline());
        exit;
}

my $options = {
        help    => 0,
};

use Getopt::Long;

GetOptions(
       "help|h" => \$options->{help}, 
);

show_usage() if $options->{help};

todo_add(my_readline());

#######################################################################

sub my_readline {
        my $content;
        my $priority;

        use Term::ReadLine;
        my $term = Term::ReadLine->new('todo');
        my $OUT = $term->OUT() || \*STDOUT;

        say "请输入需要完成的事项, 退出请输入q";

        while (1) {
                if (defined($_ = $term->readline('内容: '))) {
                        exit if /^q$/;
                        next unless /\S/;
                        $content = $_;
                        last;
                        #$term->addhistory($_);
                }
        }

        say "1: veryhigh 2: high 3: medium 4: low 5: verylow";

        say "请输入优先级，退出请输入q";

        while (1) {
                if (defined($_ = $term->readline('优先级: '))) {
                        exit if /^q$/;
                        next unless /\d/;
                        $priority = $_;
                        last;
                }
        }

        return ($content, $priority);
}

sub todo_init
{
        my ($content, $priority) = @_;
        my $todo_file = '.todo';
        my $time = time;

        my $hashref = {};
        
        $hashref->{todo} = $VERSION;
        $hashref->{notes} = {};

        $priority--;
        my $note = {
                priority => $priority,
                time => $time,
                content => $content,
        };
        $hashref->{notes}->{1} = $note;

        store $hashref, $todo_file;

        #my $xml = XMLout($ref);

        #substr $xml, 0, 0, qq{<?xml version="1.0"?>\n};

        #open my $todo_fd, ">", $todo_file or die "open: $!\n";

        #print {$todo_fd} $xml;

        #close $todo_fd;
        chmod 0600, $todo_file;

        return;
}

sub todo_add
{
        my ($content, $priority) = @_;
        my $todo_file = '.todo';
        my $time = time;

        my $hashref = retrieve $todo_file;

        my $max_id = 1;
        for my $id (keys %{$hashref->{notes}}) {
                $max_id = $max_id gt $id ? $max_id : $id;
        }
        $max_id++;

        #my @ids = (map { $_->{id}  } @{$hashref->{notes}});
        #my $max_id = max @ids;

        $priority--;

        my $note = {
                priority => $priority,
                time => $time,
                content => $content,
        };

        $hashref->{notes}->{$max_id} = $note;
        store $hashref, $todo_file;

        #my $xml = XMLout($ref);

        #substr $xml, 0, 0, qq{<?xml version="1.0"?>\n};

        #unlink $todo_file;
        #open my $todo_fd, ">", $todo_file or die "open: $!\n";

        #print {$todo_fd} $xml;

        #close $todo_fd;

        return;
}


sub show_usage {
        print <<"END_USAGE";
$0 [--help|-h]
--help|-h 打印帮助
END_USAGE
        exit;
}
