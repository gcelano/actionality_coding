xquery version "3.1" encoding "utf-8";

(: written by Giuseppe G. A. Celano, run with BaseX 8.6.7 :)

declare variable $t := 
"/Users/mycomputer/Documents/L_Universals_Aspect/Universal Dependencies 2.1/ud-treebanks-v2.1/"; 

declare variable $g := file:list($t, true(), "*.conllu");

for $w in $g
let $c := unparsed-text($t || $w)
let $o := tokenize($w, "/")
return

file:write(
"/Users/mycomputer/Documents/L_Universals_Aspect//ud-treebanks-v2.1XML/" || 
replace(tokenize($w, "/")[2], "conllu", "xml"),

<text ud_vrn="{tokenize($t, "/")[last() - 1]}" ud_tbk="{$o[1]}" ud_file="{$o[2]}"
 xquery="01_transformCoNLLintoXML.xq">
<!-- 
   s = sentence
     c = comment
       @y = type of the comment, such as sent_id
       "content of the comment"
        
     t = token
       @i = id @f = form @l = lemma @u = upostag @x = xpostag @h = head
       @d = deprel @p = deps @m = misc
       e = feats
         @z = all features together except "Aspect"
         v = feature
           @n = type of feature
           "content of the feature"   
  -->   
{
for $d at $cnt in tokenize($c, "\n\n")[position() < last()]
return
<s n="{$cnt}">{
for $i in tokenize($d, "\n")
return

if (starts-with($i, "#")) then

let $t2 := tokenize($i, " = ")
return
element c {
attribute y {replace($t2[1], "# ", "")}, $t2[2]
}
else
  let $d := tokenize($i, "\t")
  return
  element t {
  
   if ($d[1] = "_") then () else
   attribute i {$d[1] }, 
   if ($d[2] = "_") then () else
   attribute f {$d[2] },  
   if ($d[3] = "_") then () else
   attribute l {$d[3] },  
   if ($d[4] = "_") then () else
   attribute u {$d[4] },  
   if ($d[5] = "_") then () else
   attribute x {$d[5] },  
   if ($d[7] = "_") then () else
   attribute h {$d[7] },  
   if ($d[8] = "_") then () else
   attribute d {$d[8] }, 
   if ($d[9] = "_") then () else
   attribute p {$d[9] }, 
   if ($d[10] = "_") then () else
   attribute m {$d[10] },  
   if ($d[6] = "_") then () else
   element e {attribute z {
          if (matches($d[6], "Aspect=.*?\|")) then
          
          replace($d[6], "Aspect=.*?\|", "")        (: I have excluded Aspect 
                                                      because in creating a database 
                                                      in BaseX I could more easily 
                                                      compare
                                                      these values without
                                                      the need to filter 
                                                    :)
          
          else if (matches($d[6], "Aspect=.*")) then
       
          replace($d[6], "Aspect=.*", "")
          
          else $d[6]
          
          },
     for $jk in tokenize($d[6], "\|")
     let $fv := tokenize($jk, "=")
     return
     element v {attribute {"n"} {$fv[1]}, $fv[2]   }
   
      }
   
           }  
}</s>
}</text> 

)
