#!/bin/bash

set -e

# Verify if database already exists
if ! PGPASSWORD=$DATABASE_PASSWORD psql -U $DATABASE_USER -h $DATABASE_HOST -tc "SELECT 1 FROM pg_database WHERE datname = '$DATABASE_NAME'" | grep -q 1; then
  echo "Database not found. Creating..."
  bundle exec rake db:create db:migrate
else
  echo "Database already exists. Skipping creation."
fi

# Execute default command
exec "$@"
