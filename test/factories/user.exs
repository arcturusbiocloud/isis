defmodule Factory.User do
  use FactoryGirlElixir.Factory

  factory :user do
    field :email, &("user#{&1}@example.com")
    field :password, "secret"
  end
end