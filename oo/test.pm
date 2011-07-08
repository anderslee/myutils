#
#===============================================================================
#
#         FILE:  test.pm
#
#  DESCRIPTION:  Test.pm
#
#        FILES:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  anderslee (Anders Lee), anderslee@yeah.net
#      COMPANY:  just for fun
#      VERSION:  1.0
#      CREATED:  07/08/2011 11:23:32 AM
#     REVISION:  ---
#===============================================================================

package Test;

use strict;
use warnings;


our $VERSION = '0.10';

use constant TEST_ARRAY_SIZE => 10;

my %valid_flags = map { $_ => 1 } qw(
        active
);


my %valid_attrs = map { $_ => 1 } qw (
        is_active
), keys %valid_flags;

sub valid_attrs {
        my $attr = shift;

        return 1 if $valid_attrs{$attr};
        return 0;
}



sub _croak {
        require Carp;
        goto &Carp::croak;
}

sub _carp {
        require Carp;
        goto &Carp::carp;
}
