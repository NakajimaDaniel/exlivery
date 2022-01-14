defmodule Exlivery.Factory do
  use ExMachina

  alias Exlivery.Users.User

  def user_factory do
    %User{
      address: "address",
      age: 22,
      cpf: "222",
      email: "email",
      name: "name"
    }
  end
end
