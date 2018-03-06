for $t in collection("/Users/mycomputer/Documents/actionality_coding_DFG/02_aspectOppositions/")/text[@ud_tbk="UD_Kurmanji" ]

return 


copy $e := $t

modify

(
for $d1 in $e/case/aspect-values/value[@label="Prog"]
return
replace value of node $d1/@label with "Imp"

)

return 


file:write ("/Users/mycomputer/Documents/actionality_coding_DFG/02_aspectOppositions_reduced_to_Perf_Imp/UD_Kurmanji.xml", $e)

