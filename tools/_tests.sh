mkdir ./tests 2>/tmp/null


ls -l ./tests/|grep 'drwxrwxrwx' | awk 'system("./tools/_test_client.sh " $9)'
