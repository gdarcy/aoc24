#!/usr/bin/perl

use v5.34.0;

my $sum = 0;

while (<>) {
    chomp;
    my $line = $_;

    while($line =~ /mul\((\d{1,3}),(\d{1,3})\)/g) {
        $sum += ($1 * $2);
    }
}

say $sum;
exit 0;
