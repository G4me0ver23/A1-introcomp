#!/usr/bin/env bash

#Busca por title:, remove essa parte da linha e retorna somente o titulo
echo Titulo do livro: $(grep "Title:\s" ../../O_cortico.txt | sed -n 's/Title: //p')

#Conta quantas linhas, palavras e caracteres tem o arquivo
sed '/^[[:space:]]*$/d' ../../O_cortico.txt > whitoutvazio.txt #Retira linhas que estejam vazias
echo Quantidade de linhas \- Excluindo as vazias:  $(wc -l whitoutvazio.txt | sed -n 's/whitoutvazio.txt//p') \- Contando as vazias: $(wc -l ../../O_cortico.txt | sed -n 's/..\/..\/O_cortico.txt//p')

echo Quantidade de palavras: $(wc -w ../../O_cortico.txt | sed -n 's/..\/..\/O_cortico.txt//p')

sed 's/ //g' ../../O_cortico.txt > whitoutspace.txt #Retira os espacos para contar o somente os caracteres
echo Quantidade de caracteres \- Excluindo espacos em branco: $(wc -m whitoutspace.txt | sed -n 's/whitoutspace.txt//p') \- Contando espacos em branco: $(wc -m ../../O_cortico.txt | sed -n 's/..\/..\/O_cortico.txt//p')

#Busca pela linha que contem o ano (no final de uma linha, com 4 caracteres numericos)
linhaano=$(grep "[0-9]\{4\}$" ../../O_cortico.txt)
echo Ano de Publicação do livro: ${linhaano: -4} #Retorna os ultimos 4

rm whitoutvazio.txt
rm whitoutspace.txt