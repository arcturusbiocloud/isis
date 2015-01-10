defmodule Isis.Repo do
  use Ecto.Repo, adapter: Ecto.Adapters.Postgres, env: Mix.env
  
  @doc "Adapter configuration"
  def conf(env), do: parse_url url
  
  defp url do
    Application.get_env(:phoenix, :database)[:url]
  end

  def priv do
    app_dir(:isis, "priv/repo")
  end
end