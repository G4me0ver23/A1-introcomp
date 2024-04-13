#!/usr/bin/env bash

rm palavras.html

line1="<tr><th>Palavra</th>"
line2="<tr><th>Repeticoes</th>"
cont=1

sorted=$(sed 's/,/ /' ../4.\ Fourth\ Problem/vocabulario.txt | awk '{temp=$1; $1=$2; $2=temp; print}' | sort -n -r)
echo "$sorted"

#Passa pelas n mais repetidas, adicionando seu valor a tabela
while [ $cont -ne 5 ]; do
    line=$(echo "$sorted" | sed -n "${cont}p")
    word=$(echo "$line" | cut -d ' ' -f 2)
    rept=$(echo "$line" | cut -d ' ' -f 1)
    line1+="<th>$word</th>"
    line2+="<td>$rept</td>"
    cont=$((cont+1))
done

table="$(cat inicio.html)$line1</tr>$line2</tr>$(cat fim.html)"
echo "$table" >> palavras.html