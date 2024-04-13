#!/usr/bin/env bash

> vocabulario.txt

#Salva todas as palvras do texto em um array
words=($(sed 's/\n//' ../../O_cortico.txt | cat))

#Para cada palavra, verifica:
for word in ${words[@]}; do
    if [[ "${word}" =~ ^[[:upper:]] ]]; then #Se ela começa com Maiuscula
        continue
    else #Caso contrario, adiciona-a ao arquivo
        echo "$word" >> validas.txt
    fi
done

#Unifica, ordena e conta o numero de repetições de cada palavra valida do livro, salvando em linhas o numero de repetições seguido da palavra
sed 'y/áÁàÀãÃâÂéÉêÊíÍóÓõÕôÔúÚçÇ/aaaaaaaaeeeeiioooooouucc/' validas.txt |sed 's/-//' | tr '[:punct:]' ' ' | sed 's/ /\n/g' | sed 's/[^[:alnum:][:space:]]//g' | tr '[:upper:]' '[:lower:]' | sort | uniq -c > vocabulario.txt

#Retira caracteres invalidos e troca a ordem para palavra e numero de repeticoes
awk '{$1=$1};1' vocabulario.txt | awk '{temp=$1; $1=$2; $2=temp; print}' | sed 's/ /,/' > validas.txt

#Para cada palavra valida, verifica se ela tem pelo menos 4 letras:
awk -F',' 'length($1) >= 4 { print $1, $2 }' validas.txt > vocabulario.txt

rm validas.txt