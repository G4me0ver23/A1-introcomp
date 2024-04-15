#!/usr/bin/env bash

> vocabulario.txt
> validas.txt

#Considera "-" entre dois alfanumericos e apaga todos os outros nao alfanumerico, salva seomente as palvras do texto em um array
words=($(sed -r 's/([[:alnum:]])-([[:alnum:]])/\1traco\2/g' ../../O_cortico.txt | sed 's/--/ /g' | sed "s/'/aspas/g" | sed 's/[^[:alnum:][:space:]]//g' | cat))

#Para cada palavra, verifica:
for word in ${words[@]}; do
    if [[ "${word}" =~ ^[[:upper:]] ]]; then #Se ela começa com Maiuscula
        continue
    else #Caso contrario, adiciona-a ao arquivo
        echo "$word" >> validas.txt
    fi
done

#Unifica, ordena e conta o numero de repetições de cada palavra valida do livro, salvando em linhas o numero de repetições seguido da palavra
sed 's/ /\n/g' validas.txt  | tr '[:upper:]' '[:lower:]' | sort | uniq -c > vocabulario.txt

#Retira caracteres invalidos, recoloca o "-" e "'" de algumas palavras e troca a ordem para palavra e numero de repeticoes
awk '{$1=$1};1' vocabulario.txt | awk '{temp=$1; $1=$2; $2=temp; print}' | sed 's/ /,/g' | sed "s/aspas/'/" | sed 's/traco/-/g' > validas.txt

#Para cada palavra valida, verifica se ela tem pelo menos 4 letras:
awk -F',' 'length($1) >= 4 { print $1, $2 }' validas.txt > vocabulario.txt

rm validas.txt