#!/usr/bin/perl 
#===============================================================================
#
#         FILE:  test1.pl
#
#        USAGE:  ./test1.pl  
#
#  DESCRIPTION:  use BerkeleyDB
#
#      OPTIONS:  ---
# REQUIREMENTS:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  anderslee (Anders Lee), anderslee@yeah.net
#      COMPANY:  just for fun
#      VERSION:  1.0
#      CREATED:  06/28/2011 08:58:47 PM
#     REVISION:  ---
#===============================================================================

use strict;
use warnings;
use diagnostics;
use Modern::Perl;


use BerkeleyDB;

my $filename = "test1.db";

my $env = BerkeleyDB::Env->new(
        -Flags => DB_CREATE|DB_INIT_MPOOL,
) or die "cannot open BerkeleyDB::Env: $BerkeleyDB::Error\n";

my $db = tie my %hash, "BerkeleyDB::Btree",
        -Filename=> $filename,
        -Flags => DB_CREATE,
        -Env => $env,
        or die "cannot open $filename: $! $BerkeleyDB::Error";

for (my $i = 0; $i < 10; $i++) {
        $hash{$i} = $i * 100;
}

while (my($key, $value) = each %hash) {
        print "$key -> $value\n";
}

undef $db;
untie %hash;
