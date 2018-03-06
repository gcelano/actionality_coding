xquery version "3.1" encoding "utf-8";

(: written by Giuseppe G. A. Celano, run with BaseX 8.6.7 :)

for $t in (db:open("aspectOppositions")//text)
return

  copy $e := $t
  modify (
    
    replace value of node $e/@xquery with "03_p-values.xq",
    
    

    for $c in $e//case
    let $y := $c/aspect-values/value
    let $y1 := $y[@label = "Perf"]
    let $y2 := $y[@label = "Imp"]
    where ((xs:integer($y1/@total) + xs:integer($y2/@total)) div 2) >= 5 
    return  
    
      let $p-value := 
        proc:system("/usr/local/bin/Rscript", ("-e",
        "chisq.test(c(" || $y1/@total ||
        "," || $y2/@total || "), p=c(0.5, 0.5))" || "$p.value"))
        =>replace("\[1\] ", "")  =>  replace("&#xA;", "")
        
      let $yes-no := xs:double($p-value) < 0.05  
      
      return
      (insert node attribute p-value {$p-value} into $y/parent::aspect-values,
    
       insert node attribute sign 
                        {if ($yes-no) then "yes" else "no" } 
                        into $y/parent::aspect-values,
      
       insert node attribute more-frequent 
                        {if (xs:integer($y1/@total) > xs:integer($y2/@total))
                             then "Perf" else "Imp" } 
                        into $y/parent::aspect-values
    )
    
        )

return 

file:write("/Users/mycomputer/Documents/L_Universals_Aspect/p-values/" || 
$t/@ud_tbk || ".xml", $e, map {"method": "xml"})
