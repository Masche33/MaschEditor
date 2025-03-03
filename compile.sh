#!/bin/sh

# Legge il nome del progetto dalla prima riga del file .info
prog=$(head -n 1 ./.info | tr -d '\r')
if [ -z "$prog" ]; then
    echo "Errore: Il file .info non contiene un nome valido."
    exit 1
fi

# Creazione delle directory ./bin/ e ./build/ (se non esistono)
mkdir -p ./bin
mkdir -p ./build

# Pulizia delle directory ./bin/ e ./build/
rm -rf ./bin/*
rm -rf ./build/*

# Rimozione del file o link simbolico esistente con il nome del progetto
if [ -f "./$prog" ]; then
    rm "./$prog"
fi

# Trova tutti i file Assembly nella directory ./src/ e nelle sue sottodirectory
find ./src -type f -name "*.s" | while read -r file; do
    # Compilazione dei file Assembly
    output_file="./bin/$(basename "$file" .s).o"  # Salva il file oggetto in ./bin/
    as -o "$output_file" "$file" 2>>./build/assembling.log
    if [ $? -ne 0 ]; then
        echo "Errore durante l'assemblaggio del file $file. Controlla ./build/assembling.log"
        exit 1
    fi
done

# Linking di tutti i file oggetto
ld -o ./build/$prog ./bin/*.o 2>./build/linking.log
if [ $? -ne 0 ]; then
    echo "Errore durante il linking. Controlla ./build/linking.log"
    exit 1
fi

# Creazione del link simbolico ./prog che punta a ./build/$prog
ln -sf ./build/$prog ./$prog

# Messaggio di successo
echo "Compilazione e linking completati con successo."
echo "L'eseguibile si trova in ./build/$prog e il link simbolico è ./prog"
