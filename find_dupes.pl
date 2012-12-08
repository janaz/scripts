#!/usr/bin/perl -w

# to run in openwrt, install following packages
# opkg install perl perlbase-base perlbase-config perlbase-cwd perlbase-digest perlbase-essential perlbase-file perlbase-xsloader

use strict;
use File::Find;
use Digest::MD5;

my %files;
my $wasted = 0;
find(\&check_file, $ARGV[0] || ".");

#local $" = ", ";
foreach my $size (sort {$b <=> $a} keys %files) {
  next unless @{$files{$size}} > 1;
  my %md5;
  foreach my $file (@{$files{$size}}) {
    open(FILE, $file) or next;
    binmode(FILE);
    my $data;
    read FILE, $data, 10000;
    push @{$md5{Digest::MD5->new->add($data)->hexdigest}},$file;
  }
  foreach my $hash (keys %md5) {
    next unless @{$md5{$hash}} > 1;
    print scalar @{$md5{$hash}} . "\t$size\n";
    for my $f(@{$md5{$hash}}) {
      print "$f\n";
    }
    $wasted += $size * (@{$md5{$hash}} - 1);
  }
}

print "$wasted bytes in duplicated files\n";

sub check_file {
  -f && push @{$files{(stat(_))[7]}}, $File::Find::name;
}


