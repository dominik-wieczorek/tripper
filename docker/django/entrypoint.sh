#!/bin/bash

function is_postgres_ready(){
python << END
import sys
import psycopg2
try:
    conn = psycopg2.connect(dbname="$POSTGRES_DB", user="$POSTGRES_USER", password="$POSTGRES_PASSWORD", host="postgres")
except psycopg2.OperationalError:
    sys.exit(-1)
sys.exit(0)
END
}

until is_postgres_ready; do
  >&2 echo "Waiting for Postgres"
  sleep 1
done
>&2 echo "Postgres ready"

function is_neo4j_ready(){
python << END
import os, sys
from neo4j import GraphDatabase
from neo4j.exceptions import DriverError

try:
  driver = GraphDatabase.driver("bolt://neo4j:7687", auth=(os.environ["NEO4J_USER"], os.environ["NEO4J_PASSWORD"]))
  driver.verify_connectivity()
except DriverError as e:
    print(str(e))
    sys.exit(-1)

sys.exit(0)
END
}

until is_neo4j_ready; do
  >&2 echo "Waiting for Neo4j"
  sleep 1
done
>&2 echo "Neo4j ready"

cd /app
neomodel_install_labels tripper/models.py
python manage.py collectstatic --noinput
python manage.py migrate

exec "$@"
