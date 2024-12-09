#!/bin/bash

set -e

# Verifica si la base de datos ya existe
if ! PGPASSWORD=$DATABASE_PASSWORD psql -U $DATABASE_USER -h $DATABASE_HOST -c '\l' | grep -q $DATABASE_NAME; then
  echo "Database not found. Creating..."
  bundle exec rake db:create db:migrate
else
  echo "Database already exists. Skipping creation."
fi

# Ejecuta el comando por defecto
exec "$@"
