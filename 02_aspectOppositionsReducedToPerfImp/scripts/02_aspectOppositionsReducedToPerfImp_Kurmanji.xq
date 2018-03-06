xquery version "3.1" encoding "utf-8";

(: written by Giuseppe G. A. Celano, run with BaseX 8.6.7 :)


for $t in collection("/Users/mycomputer/Documents/actionality_coding_DFG/02_aspectOppositions/documents")/text[@ud_tbk="UD_Kurmanji" ]

return 


copy $e := $t

modify

(

replace value of node $e/@xquery with "02_aspectOppositionsReducedToPerfImp_Kurmanji.xq",

for $d1 in $e/case/aspect-values/value[@label="Prog"]
return
replace value of node $d1/@label with "Imp"

)

return 


file:write ("/Users/mycomputer/Documents/actionality_coding_DFG/02_aspectOppositionsReducedToPerfImp/documents/UD_Kurmanji.xml", $e)

