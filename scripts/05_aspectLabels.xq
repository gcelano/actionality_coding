
(: This query allows to know which aspect categories each treebank has. On the basis of that it was possible to write queries to reduce them to the opposition Perf-Imp :)

for $t in collection("/Users/mycomputer/Documents/actionality_coding_DFG/02_aspectOppositions/")/text
return
<r ud_tbk="{$t/@ud_tbk}">{distinct-values($t//value/@label)}</r>