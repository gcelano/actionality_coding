xquery version "3.1" encoding "utf-8";

(: written by Giuseppe G. A. Celano, run with BaseX 8.6.7 :)


declare function local:count1($c) 

{
let $f1 := $c//value[1]/verb_form
let $f2 := $c//value[2]/verb_form
where
$f1 = $f2
return
<r should-be-shorter="{$c/aspect-values/@more-frequent}" lemma="{$c/verb_lemma}">{
for $p in $f1
for $uu in  $f2
where $p = $uu
let $c1 :=
count(string-to-codepoints($p/@value))
let $c2 :=
count(string-to-codepoints($uu/@value))
return

(: :)

<coppia is-shorter="{if ($c1 = $c2) then 0 else 
                     if ($c1 < $c2) then $p/parent::value/@label else  $uu/parent::value/@label}">
<d aspect="{$p/parent::value/@label}" count="{$c1}">{$p/data(@value)}</d>
<d2 aspect="{$uu/parent::value/@label}" count="{$c2}">{$uu/data(@value)}</d2>
</coppia>
}</r>   
};


declare function local:count2($j)
{
let $c1 := count($j//coppia[@is-shorter = "Perf"])
let $c2 := count( $j//coppia[@is-shorter = "Imp"])
return
<r should-be-shorter="{$j/@should-be-shorter}" lemma="{$j/@lemma}">
<is-shorter>{if ($c1 = $c2) then 0 else if ($c1 > $c2) then "Perf" else "Imp"}
</is-shorter>
</r>  
}
;

declare function local:count3($o)
{


for $i in $o[is-shorter != "0"]
let $p := $i/@should-be-shorter
let $p1 := $i/is-shorter
where $p = $p1
return
$i


}
;

<r>{

for $ee in collection("/Users/mycomputer/Documents/actionality_coding_DFG/03_p-values/")
where $ee//case[./aspect-values[@sign = "yes"]] 




return
<file>{
  $ee//@ud_tbk,
  let $ll :=
    for $e in $ee//case[./aspect-values[@sign = "yes"]]
   
   
    return
    
      for $u in local:count1($e) return local:count2($u)
  
  return

        let $count1 := count($ll[./is-shorter != "0"][@should-be-shorter = ./is-shorter])
        let $count2 := count($ll[./is-shorter != "0"][@should-be-shorter != ./is-shorter])
        
        where $ll/is-shorter != "0"
        where $count1 + $count2 div 2 >= 5
        
        let $p := 
        
        
        
        proc:system("/usr/local/bin/Rscript", ("-e",
        "chisq.test(c(" || $count1 ||
        "," || $count2 || "), p=c(0.5, 0.5))" || "$p.value"))
        =>replace("\[1\] ", "")  =>  replace("&#xA;", "")
        return
        <r coin="{$count1}" non-coin="{$count2}"
        p-value="{$p}" sign="{if (xs:double($p) < 0.05) then "yes" else "no"}"
        
        ></r>
 
  
}
</file>

}</r>
