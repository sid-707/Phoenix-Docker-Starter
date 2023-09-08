# Wait until Postgres is ready
while ! pg_isready -q -h $POSTGRES_HOST -p $POSTGRES_PORT -U $POSTGRES_USER
do
    echo "$(data) - waiting for database to start"
    sleep 2
done

# Create, migrate, and seed db if it doesn't exist
if [[ -z `psql -Atqc "\\list $POSTGRES_DB"` ]]; then
    echo "Database $POSTGRES_DB does not exist. Creating..."
    createdb -E UTF8 $POSTGRES_DB -l en_US.UTF-8 -T template0
    mix ecto.migrate
    echo "Database $POSTGRES_DB created."
fi

exec mix phx.server