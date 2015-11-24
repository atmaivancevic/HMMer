#!/bin/bash

# $1 = Genome

# After removing all the non-ORF1s, and deleting them from $1.domains, 
# run this to extract the all the unique domains
# found in the remaining (correct) ORF1s. 
awk '{print $1}' $1.domains | sort -u > $1.domains_filtered

# convert column of results into a comma-and-space separated list
cat $1.domains_filtered | xargs | sed -e 's/ /, /g' > $1.domains_list
