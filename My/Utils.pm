#
#===============================================================================
#
#         FILE:  Utils.pm
#
#  DESCRIPTION:  My::Utils
#
#        FILES:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  anderslee (Anders Lee), anderslee@yeah.net
#      COMPANY:  just for fun
#      VERSION:  1.0
#      CREATED:  06/27/2011 06:02:53 PM
#     REVISION:  ---
#===============================================================================

use strict;
use warnings;

use POSIX qw/getpgrp tcgetpgrp/;

sub is_interactive {
        open my $TTY, "<", "/dev/tty" or die "can't open /dev/tty: $!";
        my $tpgrp = tcgetpgrp(fileno($TTY));
        my $pgrp = getpgrp();
        close $TTY;
        return ($tpgrp == $pgrp);
}

sub is_prompt {
        print "Prompt: " if is_interactive();
        return;
}


#use Smart::Comments;

#### $self
