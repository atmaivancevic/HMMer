#!/bin/bash

#$1 = Genome

# Script to append the species group/name to each confirmed ORF1 domain

#For Mammals:
# move to the appropriate directory
cd Mammals/

# Remove all blank lines from $1.domains_filtered
sed -i '/^$/d' $1.domains_filtered

# For each file contain the (unique) set of domains found in that genome, 
# append the genomes/species name as a second column to each domain
awk '{print $1 "\t" "MAMMAL_'"$1"'"}' $1.domains_filtered > $1.domains_name_appended

# #For Non-Mammal Animals (e.g. Other):
# # move to the appropriate directory
# cd NonMamm/

# # Remove all blank lines from $1.domains_filtered
# sed -i '/^$/d' $1.domains_filtered

# # For each file contain the (unique) set of domains found in that genome, 
# # append the genomes/species name as a second column to each domain
# awk '{print $1 "\t" "OTHER_'"$1"'"}' $1.domains_filtered > $1.domains_name_appended

# #For Plants:
# # move to the appropriate directory
# cd Plants/

# # Remove all blank lines from $1.domains_filtered
# sed -i '/^$/d' $1.domains_filtered

# # For each file contain the (unique) set of domains found in that genome, 
# # append the genomes/species name as a second column to each domain
# awk '{print $1 "\t" "PLANT_'"$1"'"}' $1.domains_filtered > $1.domains_name_appended
