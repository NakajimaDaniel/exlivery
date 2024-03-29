defmodule Exlivery.Orders.AgentTest do
  use ExUnit.Case
  alias Exlivery.Orders.Agent, as: OrderAgent
  alias Exlivery.Oders.Order

  import Exlivery.Factory

  describe "save/1" do
    test "Saves the order" do
      order = build(:order)

      OrderAgent.start_link(%{})

      assert {:ok, _uuid} = OrderAgent.save(order)
    end
  end

  describe "get/1" do
    setup do
      OrderAgent.start_link(%{})

      :ok
    end

    test "when the order is found, returns the order" do
      order = build(:order)

      {:ok, uuid} = OrderAgent.save(order)

      response = OrderAgent.get(uuid)

      expected_response = {:ok, order}

      assert expected_response == response
    end

    test "when the order is not found, returns an error" do
      response = OrderAgent.get("0000000")

      expected_response = {:error, "order not found"}

      assert expected_response == response
    end
  end
end
