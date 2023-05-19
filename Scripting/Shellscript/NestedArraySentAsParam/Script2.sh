for elt in "$@"; do 

    arr=(`echo $elt`)

    echo -n "Toate elem: "
    echo ${arr[@]}

    echo -n "Change directory: "
    echo "ips-tool-"${arr[0]}
    
    echo "Restul elem: "
    for i in ${arr[@]:1}; do
        echo "mvn ... $i"
    done

    echo ""
done