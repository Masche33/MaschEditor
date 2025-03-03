test_dir="./test"
for asm_file in "$test_dir"/*.s; do
    prog_name=$(basename "$asm_file" .s)
    prog_dir="$test_dir/$prog_name" # Directory associata al programma
    if [ ! -d "$prog_dir" ]; then
        echo "Errore: Directory $prog_dir non trovata per $prog_name"
        continue
    fi
    compiled_prog="$test_dir/$prog_name.out"
    as --64 "$asm_file" -o "$test_dir/$prog_name.o" 2>/tmp/null
    if [ $? -ne 0 ]; then
        echo "Errore durante l'assemblaggio di $asm_file"
        continue
    fi
    ld "$test_dir/$prog_name.o" -o "$compiled_prog"
    if [ $? -ne 0 ]; then
        echo "Errore durante il linking di $asm_file"
        continue
    fi
    for input_file in "$prog_dir"/input*; do
        test_num=$(basename "$input_file" | sed 's/input//')
        output_file="$prog_dir/output$test_num"
        if [ ! -f "$output_file" ]; then
            echo "Errore: File di output $output_file non trovato per il test $prog_name $test_num"
            continue
        fi
        actual_output=$(cat "$input_file" | "$compiled_prog")
        expected_output=$(cat "$output_file")
        if [ "$actual_output" == "$expected_output" ]; then
            echo "Test: $prog_name $test_num passed"
        else
            echo "Test: $prog_name $test_num failed"
            #echo "Expected:"
            #echo "$expected_output"
            #echo "Actual:"
            #echo "$actual_output"
        fi
    done
    rm -f "$test_dir/$prog_name.o" "$compiled_prog"
done
