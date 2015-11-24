#!/bin/bash

#$1 = Genome

# list all the sequence (headers) that were queried against Pfam
grep '>' ../Fasta_files/L1_$1_AllSeqs_Extended_orf1_filtered.fasta > $1_allSeqs.txt
# remove '>' from header beginnings
sed -i 's/>//' $1_allSeqs.txt

# remove empty lines from file
sed -i '/^$/d' $1_allSeqs.txt
# 209 seqs

# grab the headers from output that contain "Transposase_22"
cat ../$1.domains | cut -f 1,2 | grep "RRM" > $1_part1.txt

# grab the unique seq headers out of this list (no duplicates)
awk '!seen[$2]++ {print $2}' $1_part1.txt > $1_confirmedSeqs.txt
# 165 seqs

# find which seqs to remove (those that are in allSeqs.txt but not confirmedSeqs.txt)
comm -2 -3 <(sort $1_allSeqs.txt) <(sort $1_confirmedSeqs.txt) > $1_removeSeqs.txt
# 44 seqs

# Print the number of seqs to remove for this species 
wc -l $1_removeSeqs.txt

# Move this file to the new dir
mv $1_removeSeqs.txt Removal/

# This will show which sequences need to be removed (not true ORFs):
# either because they identified as something else, 
# or because they were not recognised at all 
# (so they're not present in the output file). 

# e.g. to find ORF2 candidate seqs which do not have an RVT or Endo domain (i.e. not really ORF2s):

# awk '{print $1 "\t" $4 "\t" $23 " " $24 " " $25 " " $26 " " $27 " " $28 " " $29 " " $30}' All_ORF2_candidates_filtered.fasta.out > All_ORF2.out
# awk -v i=2 'NR>1 && $i!=p { print "" }{ p = $i } 1' All_ORF2.out > All_ORF2.domains
# grep '>' All_ORF2_candidates_filtered.fasta > ORF2_allSeqs.txt
# sed -i 's/>//' ORF2_allSeqs.txt 
# sed -i '/^$/d' ORF2_allSeqs.txt
# cat All_ORF2.domains | cut -f 1,2 | grep "endo" > part1.txt
# cat All_ORF2.domains | cut -f 1,2 | grep "RVT" > part2.txt
# cat part1.txt part2.txt > part3.txt
# awk '!seen[$2]++ {print $2}' part3.txt > Endo_and_RVT_confirmedSeqs.txt
# comm -2 -3 <(sort ORF2_allSeqs.txt) <(sort Endo_and_RVT_confirmedSeqs.txt) > Endo_and_RVT_lacking_seqs.txt
# wc -l Endo_and_RVT_lacking_seqs.txt

# Only 1 seq lacked the RVT domain: 
# SolanumHabrochaites_CBYS010032250.1:0-4145(+)_-_ORF_1_(frame_1)_translation_frame_1, 
# which is actually an ORF1 seq with DUF4283 and zf-CCHC_4 domains. 
