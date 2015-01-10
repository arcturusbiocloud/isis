defmodule Isis.Repo.Migrations.InitialUsersCreate do
  use Ecto.Migration

  def up do
    [
      "CREATE TABLE users(
        id serial primary key,
        email text unique,
        password text,
        created_at timestamp,
        updated_at timestamp)",
      "CREATE UNIQUE INDEX ON users (lower(email))"
    ]
  end

  def down do
    "DROP TABLE IF EXISTS users"
  end
end
