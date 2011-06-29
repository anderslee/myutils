#!/usr/bin/perl 
#===============================================================================
#
#         FILE:  simplest calculator
#
#        USAGE:  ./calc.pl
#
#  DESCRIPTION:  store sub in a hash
#
#      OPTIONS:  ---
# REQUIREMENTS:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  anderslee (Anders Lee), anderslee@yeah.net
#      COMPANY:  just for fun
#      VERSION:  1.0
#      CREATED:  06/29/2011 03:18:18 PM
#     REVISION:  ---
#===============================================================================

use strict;
use warnings;
use diagnostics;
use Modern::Perl;

use Smart::Comments;

our $Operators = {
        '+' => sub { $_[0] + $_[1] },
        '-' => sub { $_[0] - $_[1] },
        '*' => sub { $_[0] * $_[1] },
        '**' => sub { $_[0] ** $_[1] },
        '/' => sub { $_[1] ? eval { $_[0] / $_[1] } : 'NaN' },
        '%' => sub { $_[1] ? eval { $_[0] % $_[1] } : 'NaN' },
};

while (1) {
        my ($operator, @operands) = get_line();
        ### $operator
        ### @operands
        ### $Operators


        my $some_sub = $Operators->{$operator};

        unless (defined $some_sub) {
                say "Unknown operator [$operator]";
                next;
        }

        say $Operators->{$operator}->(@operands);
}

say "Done, Exit....";

sub get_line {
        print "prompt(q to quit) jus like 1 + 2>";

        my $line = <STDIN>;
        chomp $line;

        exit if $line =~ /^q$/;

        $line =~ s/^\s+|\s+$//g;
        #$line =~ s/\d+()\S+()\d+/ /g;
        ### $line

        (split /\s+/, $line)[1, 0, 2]; # 加括号是list context
}
