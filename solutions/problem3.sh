#!/usr/bin/env bash

> ocorrencias.txt

words=($(sort ../palavras_antigas.lst | uniq))
uniqs=$(sed 's/ /\n/g' ../O_cortico.txt | sed 'y/áÁàÀãÃâÂéÉêÊíÍóÓõÕôÔúÚçÇ/aaaaaaaaeeeeiioooooouucc/' | tr -d '[:punct:]' | sort)

#Para cada palavra antiga, conta a quantidade de vezes que ela aprece
for word in ${words[@]}; do
    qtd=$(echo "$uniqs" | grep -c "$word")
    echo "$word $qtd"
done

#echo "$uniqs" >> uniq.txt