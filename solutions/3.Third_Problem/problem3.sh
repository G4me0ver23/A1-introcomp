#!/usr/bin/env bash

> ocorrencias.txt

#Unifica e ordena as palavras antigas
olds=($(sort ../../palavras_antigas.lst | sed 's/--/ /g' | sed -r 's/([[:alnum:]])-([[:alnum:]])/\1traco\2/g' | sed -r "s/([[:alnum:]])'([[:alnum:]])/\1aspas\2/g" | sed 's/[^[:alnum:][:space:]]//g' | tr '[:upper:]' '[:lower:]' | uniq))

#Unifica, ordena e conta o numero de repetições de cada palavra do livro, salvando em linhas o numero de repetições seguido da palavra
words=$(sed 's/--/ /g' ../../O_cortico.txt | sed 's/ /\n/g' | sed -r 's/([[:alnum:]])-([[:alnum:]])/\1traco\2/g' | sed -r "s/([[:alnum:]])'([[:alnum:]])/\1aspas\2/g" | sed 's/[^[:alnum:][:space:]]//g' | tr '[:upper:]' '[:lower:]' | sort | uniq -c | awk '{$1=$1};1')
echo "$words" > words.txt

#Para cada palavra antiga, conta a quantidade de vezes que ela aprece
for old in ${olds[@]}; do
    #Procura pela linha que descreve essa palavra, se ela não aparece, conta 0
    qtd=$(grep " $old$" words.txt | cut -d ' ' -f 1)
    quantidade_final=${qtd:=0}
    echo "$old $qtd" >> temp.txt
done

#Devolve os tracos e as aspas as palavras que os tinham e salva em ocorrencia.txt
sed 's/traco/-/g' temp.txt | sed "s/aspas/'/g" >> ocorrencias.txt

rm temp.txt
rm words.txt