#!/bin/bash

# concatenate all output ORF1 domain files (e.g. from each species) together
cat *.domains_name_appended > All_orf1.domains

# remove any blank lines
sed -i '/^$/d' All_orf1.domains

# sort lines 
sort All_orf1.domains > All_orf1.sorted

# merge based on column 1
awk -F'\t' -v OFS='\t' '{if ($1 in a) {a[$1] = a[$1]","$2;} else {a[$1] = $2;}} END { for (i in a) print i, a[i] }' < All_orf1.sorted > All_orf1.merged

# count the number of occurences for each domain 
awk -F '[\t,]' '{print NF-1 "\t" $0}' All_orf1.merged > All_orf1.counted

# sort the domains from highest to lowest number of occurrences
# Do this by first sorting on column 2, to sort the domains alphabetically
# Then sort on column 2, to get highest to lowest domain count
sort -k 2 All_orf1.counted > first_sort
sort -r -s -n -k 1  first_sort > All_orf1.final