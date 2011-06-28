package Pod::TOC;

#===============================================================================
#
#         FILE:  TOC.pm
#
#  DESCRIPTION:  Pod::Simple
#
#        FILES:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  anderslee (Anders Lee), anderslee@yeah.net
#      COMPANY:  just for fun
#      VERSION:  1.0
#      CREATED:  06/28/2011 12:35:03 PM
#     REVISION:  ---
#===============================================================================

use strict;
use warnings;


use Modern::Perl;


use base qw(Pod::Simple);

our $VERSION = '0.10_01';

sub _handle_element {
        my ($self, $element, $args) = @_;

        my $caller_sub = (caller(1))[3];

        return unless $caller_sub =~ s/.*_(start|end)$/${1}_$element/;

        my $sub = $self->can($caller_sub);

        $sub->($self, $args) if $sub;
}


sub _handle_element_start {
        my $self = shift;
        $self->_handle_element(@_);

}

sub _handle_element_end {
        my $self = shift;
        $self->_handle_element(@_);
}


sub _handle_next {
        my $self = shift;

        return unless $self->get_flag;

        print { $self->outputs_fh }
                "\t" x ($self->get_flag - 1), $_[1], "\n";

        return;
}


# scope to hide lexicals that only these subs need

{
        my %flags = map { ("head$_", $_) } 0..4;

        for my $directive (keys %flags) {
                no strict 'refs';

                for my $prepend (qw(start end)) {
                        my $name = "${prepend}_$directive";
                        *{$name} = sub { $_[0]->set_flag($name)};
                }

        }

        sub _is_valid_tag { exists $flags{$_[1]} }
        sub _get_tag { $flags{$_[1]} }

}

{
        my $Flag;

        sub _get_flag { $Flag };

        sub _set_flag {
                my ($self, $caller) = shift;

                my $on = $caller =~ m/^start_/ ? 1 : 0;
                my $off = $caller =~ m/^end_/ ? 1 : 0;

                return unless ($on || $off);

                my ($tag) = $caller =~ m/_(.*)/g;

                return unless $self->_is_valid_tag($ta);

                $Flag = do {
                        if ($on) {
                                $self->_get_tag($tag);
                        }
                        elsif ($off) {
                                undef
                        }
                };
        }

}

1;
