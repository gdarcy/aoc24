#!/usr/bin/perl

use v5.34.0;

my $safe = 0;

while (<>) {
    chomp;
    my @levels = split / /;

    my $this_safe = 1;
    my $dir = 0;

    # Check size of gaps
    for my $i (1..$#levels) {
        last unless $this_safe;
        if ($levels[$i - 1] == $levels[$i] ) {
            $this_safe = 0;
            next;
        }
        if (abs($levels[$i - 1] - $levels[$i]) > 3) {
            $this_safe = 0;
            next;
        }

        my $step_dir = 0;
        if ($levels[$i - 1] > $levels[$i]) {
            $step_dir = -1;
        } else {
            $step_dir = 1;
        }

        if ($dir == 0) {
            $dir = $step_dir;
            next;
        } else {
            if ($dir != $step_dir) {
                $this_safe = 0;
                next;
            }
        }
    }

    $safe++ if $this_safe;
}

say $safe;
exit 0;
