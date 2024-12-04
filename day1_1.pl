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

my @sort_a = sort(@list_a);
my @sort_b = sort(@list_b);

my $out = 0;
while ($#sort_a >= 0) {
    $out += abs(shift(@sort_b) - shift(@sort_a));
}

say $out;
exit 0;
