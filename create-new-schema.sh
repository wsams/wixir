#!/bin/bash

if [[ -z $1 ]] || [[ -z $2 ]] || [[ -z $3 ]]; then
    echo
    echo "Usage: ./create-new-schema <schema> <tablename> '<fields>'"
    echo "Example: ./create-new-schema Cat cats 'name:string age:integer'"
    echo "Note: You need to wrap your fields in single quotes to"
    echo "encapsulate the 3rd argument of this script. Also note an 'id'"
    echo "field is created automatically."
    echo
    exit
fi

schema=$1
tablename=$2
fields=$3

docker-compose run --rm -v $(pwd)/app:/app app bash \
    -c "mix phx.gen.schema ${schema} ${tablename} ${fields}"

