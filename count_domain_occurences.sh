#!/bin/bash

#$1 = Genome

# Remove all blank lines from $1.domains_filtered
sed -i '/^$/d' $1_allSeqs.txt

# For each file contain the (unique) set of domains found in that genome, 
# append the genomes/species name as a second column to each domain
awk '{print $1 "\t" "$1"}' $1.domains_filtered > $1.domains_name_appended












# Note!! Be sure to only include the 180 species with confirmed ORF1 domains, and that they don't have any # in there!
# (can check this by concatenating all 180 files and then looking for #---- etc)

# concatenate all output ORF1 domain files together
cat *.domains_filtered > All_animal_species.domains_filtered

# get rid of blank lines
sed -i '/^$/d' All_animal_species.domains_filtered

# sort lines
sort All_animal_species.domains_filtered > All_animal_species_domains.sorted

# count the number of times each domain occurs
uniq -c All_animal_species_domains.sorted > All_animal_species_domains.counted

# sort the domains from highest to lowest number of occurrences
sort -r All_animal_species_domains.counted

# make a final file which shows which species have which domains
# ideas: before concatenating all the files, make them have column1 = domain, column2 = species (e.g. by using awk print)
# then concatenate, get rid of blank lines, sort based on column 1 (domain), count the number of times each domain occurs 
# (by merging all the species with the same domain e.g.: 95 Transposase_22 Aardvark;Armadillo;BrandtsBat;...)
# then sort from highest to lowest number of occurence
# and look for any unusual shared domains across distant species, e.g. Nup35_RRM_2.

