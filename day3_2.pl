#!/usr/bin/perl

use v5.34.0;

my $sum = 0;
my $enabled = 1;

while (<>) {
    chomp;
    my $line = $_;

    while($line =~ /(mul)\((\d{1,3}),(\d{1,3})\)|(don't)\(\)|(do)\(\)/g) {
        if (defined $1) {
            $sum += ($2 * $3) if $enabled;
        } elsif (defined $4) {
            $enabled = 0;
        } elsif (defined $5) {
            $enabled = 1;
        }
    }
}

say $sum;
exit 0;
