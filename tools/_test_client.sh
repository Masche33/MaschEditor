max=$(find ./tests/$1 | grep -c 'input')
count=$( grep -c 'match' file)
for i in `seq 1 $max`
do
    ./tools/_test_unit.sh $1 $i
done