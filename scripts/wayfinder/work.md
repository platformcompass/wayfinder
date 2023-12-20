gomplate -d person=./person.json -i 'Hello {{ (datasource "person").name }}'
Hello Dave

gomplate -d person=../path/to/person.json -i 'Hello {{ (datasource "person").name }}'
Hello Dave

gomplate -d person=file:///tmp/person.json -i 'Hello {{ (datasource "person").name }}'
Hello Dave


## Env File Subst
gomplate -d envfile=./.env -i 'Hello {{ (datasource "envfile").KOMOKW_API_KEY }}'



 cat ./render.sh | envsubst