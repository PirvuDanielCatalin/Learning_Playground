for elt in "$@"; do 
    arr=(`echo $elt`)

    echo -n "Toate elem: "
    echo ${arr[@]}

    echo -n "Checkout repo: "
    echo ${arr[0]##*/}
    
    echo -n "Versiunea: "
    echo ${arr[1]}

    echo ""
done