#!/usr/bin/perl 
#===============================================================================
#
#         FILE:  wrap.pl
#
#        USAGE:  ./wrap.pl  
#
#  DESCRIPTION:  
#
#      OPTIONS:  ---
# REQUIREMENTS:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  Anders Lee (), jianghumanbu@gmail.com
#      COMPANY:  
#      VERSION:  1.0
#      CREATED:  06/17/2011 04:12:05 PM
#     REVISION:  ---
#===============================================================================

use strict;
use warnings;
use diagnostics;
use Modern::Perl;

use Hook::LexWrap qw(wrap);


sub doit {
        print "[doit: ", caller, "]\n";
        return {
                my => "data",
        };
}

SCOPED: {
        wrap doit,
                pre => sub { $_[-1] = 55; print "[pre1: ", "$_[1]", "]\n"; },
                post => sub { print "[post1: ", "$_[1]", "]\n"; };

        my $temp_wrapped = wrap doit,
                pre => sub { $_[-1] = 10; print "[pre2: $_[1]]\n"; },
                post => sub { print "[post2: $_[1]]\n" };

        my @args = ();
        doit(\@args);
        print '-' x 80, "\n";
        $temp_wrapped->(@args);
        print '-' x 80, "\n";
        
}

my @args = ();

doit(\@args);
