#!/usr/bin/env perl

# Basics: are there semantic errors which are easy to spot?

use strict;
use Test::More;

my $tests = 0;
my $prg="testssl.sh";
# Patterns used to trigger an error:

#1
printf "\n%s\n", "Testing for missing vars at left hand side in double square brackets ...";

# I know this isn't nice but perl doesn't seem for this so great either
my @matches = `grep -n '\\[\\[ [[:alpha:]]' $prg`;
is(scalar(@matches), 0, "Checking bad '[[ LHS' patterns")
    or diag(@matches);
$tests++;
i

# more would go here

printf "\n";
done_testing($tests);


#  vim:ts=5:sw=5:expandtab

