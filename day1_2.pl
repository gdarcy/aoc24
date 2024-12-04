#!/usr/bin/perl

use v5.34.0;

my (@list_a, @list_b);

for my $line (<>) {
    chomp $line;
    my @parts = split /\s+/, $line;
    push @list_a, $parts[0];
    push @list_b, $parts[1];
}

if ($#list_a != $#list_b) {
    die "List size mismatch!\n";
}

my %frequency;

for my $val_a (@list_a) {
    next if defined $frequency{$val_a};
    my $count = 0;
    for my $val_b (@list_b) {
        $count++ if ($val_b == $val_a);
    }
    $frequency{$val_a} = $count;
}

my $similarity = 0;
for my $val_a (@list_a) {
    $similarity += ($val_a * $frequency{$val_a});
}

say $similarity;
exit 0;
