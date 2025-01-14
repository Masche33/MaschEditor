mkdir ./tests 2>/tmp/null
./maschEditor < ./tests/input > ./tests/outputtest
cmp -s ./tests/output ./tests/outputtest && echo "Test passed" || echo "Test failed"
rm ./tests/outputtest