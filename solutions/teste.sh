#!/usr/bin/env bash

> ocorrencias.txt
> uniq.txt

#unifica e ordena as palavras antigas
olds=("cabide" "abide")

words=$(sed 's/ /\n/g' ../O_cortico.txt | sed 'y/áÁàÀãÃâÂéÉêÊíÍóÓõÕôÔúÚçÇ/aaaaaaaaeeeeiioooooouucc/' | tr -d '[:punct:]' | tr '[:upper:]' '[:lower:]' | sort | uniq -c | awk '{$1=$1};1')
echo "$words" > words.txt

#Para cada palavra antiga, conta a quantidade de vezes que ela aprece
for old in ${olds[@]}; do
    qtd=$(echo "$words" | grep "$old" | cut -d ' ' -f 1)
    echo "$old" >> uniq.txt
    #qtd=$(echo "$words" | grep -c "$old")
    echo "$old $qtd <-" >> uniq.txt
    echo " " >> uniq.txt
done