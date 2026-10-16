#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;

# Verify that etc/ca_hashes.txt is in sync with the CA bundles (etc/*.pem).
# Regenerates the hashes and compares content, rather than relying on
# file modification times (which git does not preserve).

# Regenerate ca_hashes.txt from the .pem bundles
my $rc = system('./utils/create_ca_hashes.sh');
is($rc, 0, "create_ca_hashes.sh exited successfully");

# Check whether the regenerated file differs from what is committed.
# Read git's exit status via system() and Perl's $?. Do NOT use a
# backtick `...; echo $?`: Perl interpolates $? as the *previous*
# command's status (the script's, always 0), so the shell would just
# echo 0 and the diff would never be detected.
my $diff_rc = system('git diff --quiet -- etc/ca_hashes.txt 2>/dev/null');
my $has_diff = (($diff_rc >> 8) == 0) ? "0" : "1";

# Restore the original file and remove the .bak the script creates
system('git checkout -- etc/ca_hashes.txt 2>/dev/null');
unlink 'etc/ca_hashes.txt.bak';

is($has_diff, "0",
   "ca_hashes.txt is up to date with the .pem bundles (run ./utils/create_ca_hashes.sh if not)");

done_testing;


#  vim:ts=5:sw=5:expandtab

