<text ud_vrn="ud-treebanks-v2.1" ud_tbk="UD_Russian-SynTagRus" xquery="04_evaluationByNativeSpeakerRussian.xq">

{


for $t in doc("/Users/mycomputer/Documents/actionality_coding/p-values/UD_Russian-SynTagRus.xml")/text/case[./aspect-values[@sign="yes"]]

return

 <case n="{$t/@n}" expected_as="">
 {$t/verb_lemma}

 </case> 
  
}

</text>