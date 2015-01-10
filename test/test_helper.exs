Isis.Endpoint.start
ExUnit.start [max_cases: 1]

Mix.Task.run "ecto.drop", ["Isis.Repo"]
Mix.Task.run "ecto.create", ["Isis.Repo"]
Mix.Task.run "ecto.migrate", ["Isis.Repo"]

Path.join(__DIR__, "factories/*.exs")
|> Path.wildcard
|> Enum.each(&Code.require_file/1)

defmodule IsisTest.Case do
  use ExUnit.CaseTemplate

  setup do
    :ok = Ecto.Adapters.Postgres.begin_test_transaction(Isis.Repo)
    on_exit fn ->
      :ok = Ecto.Adapters.Postgres.rollback_test_transaction(Isis.Repo)
    end
    :ok
  end

  using do
    quote do
      import IsisTest.Case
      import Isis.Router.Helpers
    end
  end
end
