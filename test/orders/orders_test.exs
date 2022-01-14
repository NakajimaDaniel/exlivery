defmodule Exlivery.Orders.OrderTest do
  use ExUnit.Case

  alias Exlivery.Orders.Order

  import Exlivery.Factory

  describe "build/2" do
    test "when all params returns a order" do
      user = build(:user)

      items = [
        build(:item),
        build(:item, description: "Teste", category: :japonesa, quantity: 1)
      ]

      response = Order.build(user, items)

      expected_response = {:ok, build(:order)}

      assert response == expected_response
    end

    test "when there is no items in the order, returns a error" do
      user = build(:user)

      items = []

      response = Order.build(user, items)

      expected_response = {:error, "Invalid Parameter"}

      assert response == expected_response
    end
  end
end
