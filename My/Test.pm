package My::Test;

use 5.006001; # only work for 5.6.1 or later

use version;

our $VERSION = qv('0.0.1_1');

use IO::Prompt 0.002 qw(prompt);

use Carp qw(croak);
use List::Util 1.13 qw(max);


use Benchmark qw(cmpthese);


BEGIN {
        croak 'Local::Test only works under 5.6.1 or later, but not 5.8.0'
                if $] < qv('5.6.1') || $] == qv('5.8.0');

        croak 'IO::Prompt must be 0.2.0 or later, but not 0.3.1 to 0.3.3'
                if $IO::Prompt::VERSION < qv('0.2.0')
                        || $IO::Prompt::VERSION >= qv('0.3.1')
                                && $IO::Prompt::VERSION <= qv('0.3.3');

        croak 'Benchmark must be later than version 1.52'
                if $Benchmark::VERSION < qv('1.52');
}


use base qw(Exporter);

our @EXPORT = qw(ok skip pass fail);    # 默认导出
our @EXPORT_OK = qw(ok skip pass fail); # 显式请求才会导出
