#!/usr/bin/env perl

use strict;
use warnings;
use GetOpt::Long;

use Bio::TreeIO;
use Bio::Tree::Tree;
use Bio::Tree::Node;

use DBI;

# <<Add an option to allow a tree to be constructed from just a list of OTUs>>
my %opts;
GetOptions (\%opts, "help|h",
			"man|m") or pod2usage(2);

pod2usage(1) if $opts{"help"};
pod2usage(-exitstatus => 0, -verbose => 2) if $opts{"man"};

# <<Use Catalyst for connecting to database>>
my $dbi = DBI->connect("dbi:Pg:dbname=phylostore;host=localhost;port=5432");

# <<Connect to db>>
my $

# <<Fetch tree info from the database>>

	# <<Construct Tree using Node, Tree>>

# <<Create and output a PhyloXML file>>

################# POD Documentation ##################

__END__

=head1 NAME

get_orth_orfs.pl - Fasta tools based on BioPerl

=head1 SYNOPSIS

B<generate-tree.pl> [options]

=head1 DESCRIPTION

B<generate-tree.pl> is a script used by a GMatchbox frontend (or a web page
using the frontend) to generate a tree from the phylostore phylogenetic
schema. It can be used for generating a tree to be used by a tree-viewer such
as Phylobox. It can also be used for generating a tree if the client
application wants to provide a tree output with user choice format.

By default, it will generate a PhyloXML tree file using BioPerl's TreeIO
module, but can be expanded to use any output format that TreeIO supports.

It currently takes no options, 

=head1 OPTIONS

=over 4

=item B<--help, -h>

Print a brief help message and exits.

=item B<--man, -m>

Prints the manual page and exits.

=back

=head1 EXAMPLES

Section under construction...

=head1 REQUIRES

Perl, Getopt::Long, Pod::Usage, Bio::Tree::Tree, Bio::Tree::Node

=head1 SEE ALSO

  perl(1)

=head1 AUTHORS

 Yözen Hernández yzhernand at gmail dot com
 (Credit to Catalyst devs when this is implemented)
 (Credit Ben Hitz and Eric Lyons for the schema used in GMatchbox)

=cut

##################### End ##########################