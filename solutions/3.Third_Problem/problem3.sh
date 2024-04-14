#!/usr/bin/env bash

> ocorrencias.txt

#Unifica e ordena as palavras antigas
olds=($(sort ../../palavras_antigas.lst | sed -r 's/([[:alnum:]])-([[:alnum:]])/\1traco\2/g' | sed 'y/áÁàÀãÃâÂéÉêÊíÍóÓõÕôÔúÚçÇ/aaaaaaaaeeeeiioooooouucc/' | tr -d '[:punct:]' | tr '[:upper:]' '[:lower:]' | uniq))

#Unifica, ordena e conta o numero de repetições de cada palavra do livro, salvando em linhas o numero de repetições seguido da palavra
words=$(sed 's/ /\n/g' ../../O_cortico.txt | sed -r 's/([[:alnum:]])-([[:alnum:]])/\1traco\2/g' | sed 'y/áÁàÀãÃâÂéÉêÊíÍóÓõÕôÔúÚçÇ/aaaaaaaaeeeeiioooooouucc/' | tr -d '[:punct:]' | tr '[:upper:]' '[:lower:]' | sort | uniq -c | awk '{$1=$1};1')
echo "$words" > words.txt

#Para cada palavra antiga, conta a quantidade de vezes que ela aprece
for old in ${olds[@]}; do
    #Procura pela linha que descreve essa palavra, se ela não aparece, conta 0
    qtd=$(grep " $old$" words.txt | cut -d ' ' -f 1)
    quantidade_final=${qtd:=0}
    echo "$old $qtd" >> temp.txt
done

#Devolve os tracos e as aspas as palavras que os tinham e salva em ocorrencia.txt
sed 's/traco/-/' temp.txt >> ocorrencias.txt

rm temp.txt
rm words.txt