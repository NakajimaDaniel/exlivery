defmodule Exlivery.Factory do
  use ExMachina

  alias Exlivery.Users.User
  alias Exlivery.Orders.{Item, Order}

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

  def order_factory do
    %Order{
      delivery_address: "address",
      items: [
        build(:item),
        build(:item, description: "Teste", category: :japonesa, quantity: 1)
      ],
      total_price: Decimal.new("46.00"),
      user_cpf: "222"
    }
  end
end
