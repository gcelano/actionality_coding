for $t at $c in tokenize(unparsed-text("/Users/mycomputer/Documents/L_Universals_Aspect/Universal Dependencies 2.1/ud-treebanks-v2.1/UD_Russian-SynTagRus/ru_syntagrus-ud-train.conllu"), "\n\n")
return
replace(replace($t, ".$", xs:string($c)), "\n", concat("	", $c, "
") )