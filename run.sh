for i in {0..15..1}
do
    directory=$(printf %02d $i)
    cd $directory
    
    printf "Running $i"
    psql -d senators -f main.sql > output.txt
    diff output.txt correct.txt --suppress-common-lines -y -a -W 230 > diff.txt
    isdifferent=$(diff output.txt correct.txt -q)
    
    if [ -z "$isdifferent" ]
    then
        echo " - Perfect match!"
    else
        echo " - Output did not match answer is question $i"
        echo "                                             Your output                                           |                                             Correct output"
        cat diff.txt
        break
    fi

    cd ..
done
