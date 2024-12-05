#!/usr/bin/perl

use v5.34.0;
use POSIX qw/ceil/;

my (@rules, @updates);

while (<>) {
    chomp;
    if (/\|/) {
        push @rules, $_;
    } elsif (/,/) {
        push @updates, [ split /,/, $_ ];
    }
}

# Parse the rules out
my %rulemap;
foreach my $rule (@rules) {
    my ($left, $right) = split /\|/, $rule; # fix syntax highlighting! /
    $rulemap{$left} = {} unless exists $rulemap{$left};
    $rulemap{$left}{$right} = 1;
}

my $middles = 0;
# Test the updates
foreach my $update (@updates) {
    my $valid = 1;
    for my $n (0..$#{$update}) {
        next unless exists $rulemap{$update->[$n]};
        next if $n == 0; # Can't have a previous page if you're the first page
        for my $prev (0..$n - 1) {
            $valid = 0 if exists $rulemap{$update->[$n]}{$update->[$prev]};
            last unless $valid;
        }
        last unless $valid;
    }
    next unless $valid;

    $middles += $update->[ceil($#{$update} / 2)];
}

say $middles;
exit 0;
