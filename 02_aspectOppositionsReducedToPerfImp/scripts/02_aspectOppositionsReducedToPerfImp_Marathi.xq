for $t in collection("/Users/mycomputer/Documents/actionality_coding_DFG/02_aspectOppositions/")/text[@ud_tbk="UD_Marathi" ]

return 


copy $e := $t

modify

(
  
replace value of node $e/@xquery with "02_aspectOppositionsReducedToPerfImp_Marathi.xq",  
  
for $d1 in $e/case/aspect-values/value[@label="Hab"]/verb_form

for $d2 in $e/case/aspect-values/value[@label="Imp"]/verb_form
where ($d1/@value = $d2/@value) and ($d1 = $d2)

return
(replace value of node $d2/@total with  $d2/@total + $d1/@total,

delete node $d1


) 
)

return 

copy $i := $e
modify
(
for $u in $i//value[@label="Imp"]
let $o := $u/verb_form
let $l := $u/parent::aspect-values/value[@label="Hab"]/verb_form
return
(replace node $u with
element value {$u/@label, $u/@total, $o union $l},
delete node $u/parent::aspect-values/value[@label="Hab"])  
)

return

copy $d := $i

modify(
for $u in $d//value[@label="Hab"]
return
replace value of node $u/@label with "Imp"
  
)
return 


copy $h := $d
modify
(
for $o in $h//value  
let $t := sum($o/verb_form/@total)
return
replace value of node $o/@total with $t
)
return 

file:write ("/Users/mycomputer/Documents/actionality_coding_DFG/02_aspectOppositionsReducedToPerfImp/documents/UD_Marathi.xml", $h)

