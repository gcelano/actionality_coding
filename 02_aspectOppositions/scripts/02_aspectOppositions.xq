xquery version "3.1" encoding "utf-8";

(: written by Giuseppe G. A. Celano, run with BaseX 8.6.7 :)

let $t2 := db:open("ud-treebanks-v2.1XML_Final")/text[s/t/e/v/@n="Aspect"]
let $o := distinct-values($t2/@ud_tbk)
for $gg in $o
let $t := <c>{$t2[@ud_tbk= $gg]}</c>
return

file:write("/Users/mycomputer/Documents/L_Universals_Aspect/aspectOppositions/" || 
$gg || ".xml" ,  
  
  
    <text ud_vrn="ud-treebanks-v2.1" ud_tbk="{$gg}" xquery="02_aspectOppositions.xq">{ 
     
     
    let $uio := (: this 'let clause' serves to order the results :)
    
    let $r := $t/text/s/t[@u = "VERB"]
    let $pr := $r/e/v[@n="Aspect"]
    let $int := $pr/ancestor::t/lower-case(@l)
    let $dvL := distinct-values($int)
    let $dvA := distinct-values($pr)
    return
    for $jj at $count in $dvL
    return
    <case n="{$count}">
      <verb_lemma>{$jj}</verb_lemma>
         <aspect-values>{
                    for $a in $dvA
                    let $d := $pr[ancestor::t/lower-case(@l) = $jj][. = $a]/ancestor::t
                    where $d
                    return
                    <value label="{$a}" total="{count($d)}">
                    { 
                     let $ax := $d/@f
                    
                     let $fin := for $i in $ax 
                                 return
                                 $i/lower-case(.) || "+%+" || $i/parent::t/e/@z
                     
                     
                     let $f := distinct-values($fin)
                     for $ff in $f
                     let $cc := count(for $y in $ax[lower-case(.) || "+%+" || ./parent::t/e/@z = $ff] return $y/parent::t)
                     order by $cc descending 
                     let $xc := tokenize($ff, "\+%\+")
                     return
                     <verb_form total="{$cc}" value="{$xc[1]}">{$xc[2]}</verb_form>
                    }</value>
         }</aspect-values>
      
    </case>
    
    
    for $tt in $uio
    
    let $sdf := $tt/aspect-values/value
    
    where count($sdf) > 1 
    
    order by sum($sdf/@total/xs:integer(.)) descending
    
    return
    $tt
}</text>
)

      
      
