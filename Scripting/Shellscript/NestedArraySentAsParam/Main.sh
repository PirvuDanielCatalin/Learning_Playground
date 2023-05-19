echo "> Cazul 1 <"
echo "> Nested array pe bune <"

bash Script1.sh \
    "vocalink/ips-tool-rabbitmq 1.0.1-4" \
    "vocalink/ips-tool-database 1.0.1-2"
bash Script2.sh \
    "rabbitmq middleware-rabbit" \
    "database middleware-db2-10 middleware-db2-11"

echo ">----------<"

echo "> Cazul 2 <"
echo "> Array simplu <"

bash Script1.sh "vocalink/ips-tool-rabbitmq 1.0.1-4"
bash Script2.sh "rabbitmq middleware-rabbit"

echo ">----------<"

echo "> Cazul 3 <"
echo "> Fara parametru <"

bash Script1.sh
bash Script2.sh

echo ">----------<"