#!/usr/bin/perl 
#===============================================================================
#
#         FILE:  padmin.pl
#
#        USAGE:  ./padmin.pl  
#
#  DESCRIPTION:  ptodo admin
#
#      OPTIONS:  ---
# REQUIREMENTS:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  anderslee (Anders Lee), anderslee@yeah.net
#      COMPANY:  just for fun
#      VERSION:  1.0
#      CREATED:  06/30/2011 06:43:27 AM
#     REVISION:  ---
#===============================================================================

use strict;
use warnings;
use diagnostics;
use Modern::Perl;


use Getopt::Long;

my $options = {
        help => 0,
        edit => 0,
        remove => 0,
        done => 0,
};

GetOptions(
        "help|h" => \$options->{help},
        "edit|e" => \$options->{edit},
        "remove|r" => \$options->{remove},
        "done|d" => \$options->{done},
);

show_usage() if $options->{help};


# #####################################################################

sub show_usage {
        print <<"END_USAGE";
$0 [--help|-h] --edit|-e --remove|-r --done|-d
--help|-h 打印帮助
--edit|-e 修改事项
--remove|-r 删除事项
--done|-d 完成事项
END_USAGE
        exit;
}
