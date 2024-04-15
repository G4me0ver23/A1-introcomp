#!/usr/bin/env bash

> palavras.html

echo "n palavras mais repetidas: "
read n

lines="<tr class=\"headtable\"><th>Palavra</th><th>Repeticoes</th></tr>"
class=""
cont=1

sorted=$(sed 's/,/ /' ../4.Fourth_Problem/vocabulario.txt | awk '{temp=$1; $1=$2; $2=temp; print}' | sort -n -r)
echo "$sorted" > sorted.txt

#Salva as palavras antigas sem pontuacao, somente minusculas
olds=$(sort ../../palavras_antigas.lst | tr '[:upper:]' '[:lower:]' | uniq)

#Passa pelas n mais repetidas, adicionando seu valor a tabela
while [ $cont -le $n ]; do
    class=""
    line=$(echo "$sorted" | sed -n "${cont}p")
    word=$(echo "$line" | cut -d ' ' -f 2)
    rept=$(echo "$line" | cut -d ' ' -f 1)

    #Checa se essa palavra e uma palavra antiga
    qtd=$(echo "$olds" | grep -c "^$word$")
    
    if [ $qtd -gt 0 ]; then #Se for, adiciona uma classe css
        class=' class="olds"'
    fi
    lines+="<tr><td$class>$word</td><td$class>$rept</td></tr>"
    cont=$((cont+1))
done

table="$(cat inicio.html)$lines$(cat fim.html)"
echo "$table" >> palavras.html