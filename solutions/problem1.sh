#!/usr/bin/env bash

#Coloca a relação de arquivos do diretorio atual em um array
files=($(ls))
ls -l

#Para cada arquivo, le a primeira linha e identifica o padrao procurado: "#!/bin/bash"
for file in ${files[@]}; do
    cont=($(sed -n 1p $file | grep -c \#!/bin/bash))

    if [ $cont -ge 1 ]; then #Se houver um #!/bin/bash, limita a opção de executar apenas para o usuario e seu grupo
        #echo "$PWD/$file"
        chmod ug+rx $file
    fi
    ls -l
done

