#!/usr/bin/perl

use v5.34.0;
use feature 'signatures';
no warnings 'experimental::signatures';

my @lines;
my $found = 0;

while (<>) {
    chomp;
    push @lines, [ split //, $_ ];
}

for my $row_number (0..$#lines) {
    my $row = $lines[$row_number];
    for my $column_number (0..$#{$row}) {
        # MAS left-arm cross
        $found++ if (search_diag($column_number, $row_number, \@lines, "M", "MAS"));
        # SAM left-arm cross
        $found++ if (search_diag($column_number, $row_number, \@lines, "S", "SAM"));
    }
}

say "Found $found";
exit 0;

sub search_diag ($column_number, $row_number, $lines, $key, $string) {
    # Check for left-arm
    if ($column_number <= $#{$lines->[$row_number]} - 2 && $lines->[$row_number]->[$column_number] eq $key) {
        my $text = $key;
        for my $n (1..2) {
            $text .= $lines->[$row_number + $n]->[$column_number + $n];
        }
        return 0 if ($text ne $string);
    } else {
        return 0;
    }

    # Check for right-arm
    my $invert = join('', reverse(split //, $string));
    for my $target ($string, $invert) {
        my $col = $column_number + 2;
        my $key = substr($target, 0, 1);
        if ($col >= 2 && $lines->[$row_number]->[$col] eq $key) {
            my $text = $key;
            for my $n (1..2) {
                $text .= $lines->[$row_number + $n]->[$col - $n];
            }
            return 1 if ($text eq $target);
        }
    }
}
