defmodule Isis.Mixfile do
  use Mix.Project

  def project do
    [app: :isis,
     version: "0.0.1",
     elixir: "~> 1.0",
     elixirc_paths: ["lib", "web"],
     compilers: [:phoenix] ++ Mix.compilers,
     deps: deps(Mix.env) ]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [
      mod: {Isis, []},
      applications: applications(Mix.env) 
    ]
  end
  
  defp applications do
    [
      :phoenix,
      :cowboy,
      :logger,
      :bcrypt,
      :postgrex,
      :ecto
    ]
  end
  
  defp applications(:test) do
    applications ++ [
      :hound,
      :factory_girl_elixir
    ]
  end
  
  defp applications(_), do: applications
  
  # Specifies your project dependencies
  #
  # Type `mix help deps` for examples and options
  defp deps do
    [
      {:phoenix, "~> 0.7.2"},
      {:cowboy, "~> 1.0"},
      {:bcrypt, github: "opscode/erlang-bcrypt"},
      {:postgrex, "~> 0.6.0"},
      {:ecto, "~> 0.2.5"}
    ]
  end
  
  defp deps(:test) do
    deps ++ [
      {:ibrowse, github: "cmullaparthi/ibrowse", tag: "v4.1.1", optional: true},
      {:hound, "~> 0.6.0"},
      {:factory_girl_elixir, "~> 0.1.1"}
    ]
  end
  
  defp deps(_), do: deps

end
