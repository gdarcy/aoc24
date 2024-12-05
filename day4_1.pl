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
        # XMAS forwards
        $found++ if (search_row($column_number, $row, "XMAS"));
        # XMAS backwards
        $found++ if (search_row($column_number, $row, "SAMX"));
        # XMAS straight down
        $found++ if (search_column($column_number, $row_number, \@lines, "X", "XMAS"));
        # XMAS straight upwards
        $found++ if (search_column($column_number, $row_number, \@lines, "S", "SAMX"));
        # XMAS downwards \
        $found++ if (search_diag($column_number, $row_number, \@lines, "X", "XMAS", 1));
        # XMAS downwards /
        $found++ if (search_diag($column_number, $row_number, \@lines, "X", "XMAS", -1));
        # XMAS upwards \
        $found++ if (search_diag($column_number, $row_number, \@lines, "S", "SAMX", 1));
        # XMAS upwards /
        $found++ if (search_diag($column_number, $row_number, \@lines, "S", "SAMX", -1));
    }
}

say "Found $found";
exit 0;

sub search_row ($column_number, $row, $string) {
    return 1 if ($column_number <= $#{$row} - 3 && join('', @$row[$column_number..$column_number + 3]) eq $string);
}

sub search_column ($column_number, $row_number, $lines, $key, $string) {
    if ($row_number <= $#{$lines} - 3 && $lines->[$row_number]->[$column_number] eq $key) {
        my $text = $key;
        for my $n (1..3) {
            $text .= $lines->[$row_number + $n]->[$column_number];
        }
        return 1 if ($text eq $string);
    }
}

# direction is +1 for \, -1 for /
sub search_diag ($column_number, $row_number, $lines, $key, $string, $direction) {
    if ($direction == 1) {
        if ($column_number <= $#{$lines->[$row_number]} - 3 && $lines->[$row_number]->[$column_number] eq $key) {
            my $text = $key;
            for my $n (1..3) {
                $text .= $lines->[$row_number + $n]->[$column_number + $n];
            }
            return 1 if ($text eq $string);
        }
    } else {
        if ($column_number >= 3 && $lines->[$row_number]->[$column_number] eq $key) {
            my $text = $key;
            for my $n (1..3) {
                $text .= $lines->[$row_number + $n]->[$column_number - $n];
            }
            return 1 if ($text eq $string);
        }
    }
}