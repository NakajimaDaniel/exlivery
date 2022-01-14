defmodule Exlivery.Factory do
  use ExMachina

  alias Exlivery.Users.User
  alias Exlivery.Orders.Item

  def user_factory do
    %User{
      address: "address",
      age: 22,
      cpf: "222",
      email: "email",
      name: "name"
    }
  end

  def item_factory do
    %Item{
      description: "description",
      category: :pizza,
      quantity: 1,
      unit_price: Decimal.new("23")
    }
  end
end
