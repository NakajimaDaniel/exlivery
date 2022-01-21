defmodule Exlivery.Orders.CreateOrUpdateTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.CreateOrUpdate
  alias Exlivery.Users.Agent, as: UserAgent

  describe "call/1" do
    setup do
      cpf = "12345678900"
      user = build(:user, cpf: cpf)

      Exlivery.start_agents()
      UserAgent.save(user)

      item1 = %{
        description: "description",
        category: :pizza,
        unit_price: "222",
        quantity: 1
      }

      item2 = %{
        description: "description",
        category: :pizza,
        unit_price: "222",
        quantity: 1
      }

      {:ok, user_cpf: cpf, item1: item1, item2: item2}
    end

    test "when all params are valid, saves the order", %{
      user_cpf: cpf,
      item1: item1,
      item2: item2
    } do
      params = %{user_cpf: cpf, items: [item1, item2]}

      response = CreateOrUpdate.call(params)

      assert response == "rerrrer"
    end
  end
end
