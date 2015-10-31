#!/bin/bash

#$1 = Genome

awk '{print $1 "\t" $4 "\t" $23 " " $24 " " $25 " " $26 " " $27 " " $28 " " $29 " " $30}' L1_$1_AllSeqs_Extended_orf1_filtered.fasta.out > $1.out
