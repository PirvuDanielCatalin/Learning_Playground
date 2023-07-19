QM='000000090A101_MQ1'
echo "######################"
echo "Run for QM $QM"
echo "######################"
for que in $(echo "DISPLAY Q(*)" | runmqsc $QM | grep 'QUEUE' | sed 's/.*QUEUE(\(.*\))/\1/g' | sed 's/).*//g' | xargs)
do
  echo "######################"
  echo "Showing properties for Queue $que"
  echo "######################"
  echo "DISPLAY Q($que)" | runmqsc $QM
  echo "######################"
  persistence_status="$( echo "DISPLAY Q($que)" | runmqsc $QM | grep DEFPSIST | sed 's/.*DEFPSIST(//g' | sed 's/).*//g' )"
  case "${persistence_status}" in
    NO)
      echo "DEFPSIST($persistence_status) ==> NU ESTE persistent"
      ;;
    YES)
      echo "DEFPSIST($persistence_status) ==> ESTE persistent"
      ;;
    *)
      echo "DEFPSIST($persistence_status) ==> Ceva status dubios"
      ;;
  esac
  echo "######################"
  echo
  echo
done