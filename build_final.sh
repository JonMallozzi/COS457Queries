echo "Jon Mallozzi"
echo "2019-10-25"
echo "Professor Briggs"

for i in {1..15..1}
do
    directory=$(printf %02d $i)
    cd $directory
    
#   printf "Running $i"
    echo "----------------------------- Problem ${i} -----------------------------"
    cat main.sql
    echo ""
    echo ""
    echo "----------------------------- Solution ${i} -----------------------------"
    #lines=${($(wc -l output.txt))[0]}
    a=($(wc output.txt))
    lines=${a[0]}
    if [ $lines -lt 30 ]
    then
        cat output.txt
    else
        head -n 10 output.txt
        echo "..."
        tail -n 10 output.txt
    fi
    echo ""
    echo ""
    echo ""
    cd ..
done
