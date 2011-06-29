#!/usr/bin/perl 
#===============================================================================
#
#         FILE:  perltdd.pl
#
#        USAGE:  ./perltdd.pl  
#
#  DESCRIPTION:  perl tdd
#
#      OPTIONS:  ---
# REQUIREMENTS:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  anderslee (Anders Lee), anderslee@yeah.net
#      COMPANY:  just for fun
#      VERSION:  1.0
#      CREATED:  06/28/2011 03:44:17 PM
#     REVISION:  ---
#===============================================================================

use strict;
use warnings;
use diagnostics;
use Modern::Perl;


use Storable;
use Smart::Comments;

use Term::ANSIColor;

my $VERSION = '0.10';

my $todo_file = '.todo';


my @PRIORITY = qw(veryhigh high medium low verylow);
my @color = qw(red yellow green blue cyan);


unless (-f '.todo') {
        say ".todo doesn't exist, please use perltda to create one";
        exit;
}

use Getopt::Long;

my $options = {
        help => 0,
};

GetOptions(
        "help|h" => \$options->{help},
);

show_usage() if $options->{help};

my $hashref = retrieve $todo_file;

todo_done();

store $hashref, $todo_file;

# #####################################################################

sub todo_done {
        my $id;
        my $comment;

        use Term::ReadLine;
        my $term = Term::ReadLine->new('todo');
        my $OUT = $term->OUT() || \*STDOUT;

        say "请输入已经完成事项的序号, 退出请输入q";

        while (1) {
                if (defined($_ = $term->readline('序号: '))) {
                        exit if /^q$/;
                        next unless /^\d$/;
                        $id = $_;
                        last;
                        #$term->addhistory($_);
                }
        }

        if ( !defined $hashref->{notes}->{$id}
                || defined $hashref->{notes}->{$id}->{done}) {
                say "the id you typed is not legal";
                say "please use perltodo to check your todo list";
                exit;
        }
 

        my $priority = $hashref->{notes}->{$id}->{priority};
        my $content = $hashref->{notes}->{$id}->{content};

       
        ### $priority
        ### $content
        
        printf ("%4d: ", $id);
        print color $color[$priority];
        print $content;
        
        print color 'reset';
        print "\n";
 

        say "请输入备注, 退出请输入q";
        while (1) {
                if (defined($_ = $term->readline('备注: '))) {
                        exit if /^q$/;
                        next unless /\S/;
                        $comment = $_;
                        last;
                        #$term->addhistory($_);
                }
        }

        $hashref->{notes}->{$id}->{done} = [$comment, time];


#        say "1: veryhigh 2: high 3: medium 4: low 5: verylow";
#
#        say "请输入优先级，退出请输入q";
#
#        while (1) {
#                if (defined($_ = $term->readline('优先级'))) {
#                        exit if /^q$/;
#                        next unless /\d/;
#                        $priority = $_;
#                        last;
#                }
#        }
#
#        return ($content, $priority);
        return;
}

#sub todo_init
#{
#        my ($content, $priority) = @_;
#        my $todo_file = '.todo';
#        my $time = time;
#
#        my $hashref = {};
#        
#        $hashref->{todo} = $VERSION;
#        $hashref->{notes} = [];
#
#        my $note = {
#                id => 1,
#                priority => $PRIORITY[$priority],
#                time => $time,
#
#
sub print_default
{
        return;
}


sub show_usage {
        print <<"END_USAGE";
$0 [--help|-h]
--help|-h 打印帮助
END_USAGE
        exit;
}
