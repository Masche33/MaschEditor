if [ -z "$1" ]; then
    echo "Error: project name was not specified."
    echo "Utilizzo: $0 <nome_progetto>"
    exit 1
fi

mkdir ./$1  2>/tmp/null
cd ./$1
mkdir ./src 2>/tmp/null
printf ".intel_syntax noprefix\n.globl _start\n_start:\n    mov rax, 60\n    syscall\n" > ./src/main.s
printf "$1" > ./.info
printf "/bin\n/build\n" > ./.gitignore