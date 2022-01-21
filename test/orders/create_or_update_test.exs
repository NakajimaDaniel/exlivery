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

      assert {:ok, _uuid} = response
    end

    test "when there is no user with given cpf, returns a error", %{item1: item1, item2: item2} do
      params = %{user_cpf: "22222222222", items: [item1, item2]}

      response = CreateOrUpdate.call(params)

      expected_response = {:error, "user not found"}

      assert expected_response == response
    end

    test "when there are invalid items, returns an error", %{
      user_cpf: cpf,
      item1: item1,
      item2: item2
    } do
      params = %{user_cpf: cpf, items: [%{item1 | quantity: 0}, item2]}

      response = CreateOrUpdate.call(params)

      expected_response = {:error, "Invalid Items"}

      assert expected_response == response
    end

    test "when there are no items, returns an error", %{
      user_cpf: cpf,
    } do
      params = %{user_cpf: cpf, items: []}

      response = CreateOrUpdate.call(params)

      expected_response =  {:error, "Invalid Parameters"}

      assert expected_response == response
    end


  end
end
