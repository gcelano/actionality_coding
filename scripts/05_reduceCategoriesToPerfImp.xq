for $t in collection("/Users/mycomputer/Documents/actionality_coding_DFG/02_aspectOppositions/")/text[@ud_tbk="UD_Basque" ]

return 


copy $e := $t

modify

(
for $d1 in $e/case/aspect-values/value[@label="Prog"]/verb_form
return
for $d2 in $e/case/aspect-values/value[@label="Imp"]/verb_form
where ($d1/@value = $d2/@value) and ($d1 = $d2)

return
replace value of node $d2/@total with  $d2/@total + $d1/@total  
  
)

return $e