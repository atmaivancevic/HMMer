#!/bin/bash

#$1 = Genome

# Separate each ORF by a blank line
awk -v i=2 'NR>1 && $i!=p { print "" }{ p = $i } 1' $1.out > $1.domains
# i.e. on any line after the first, if the value of the "i"-th column (where i=1) is different to the previous value, print a blank line. 
# Always set the value of p
# 1 at the end means true - so that awk prints the line
