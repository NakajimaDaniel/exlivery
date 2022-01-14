defmodule Exlivery.Orders.ItemTest do
  use ExUnit.Case

  alias Exlivery.Orders.Item

  import Exlivery.Factory

  describe "build/4" do
    test "when all params returns a item" do
      response = Item.build("description", :pizza, "23", 1)

      expected_response = {:ok, build(:item)}

      assert response == expected_response
    end

    test "when there is an invalid category returns a error" do
      response = Item.build("description", :nan, "23", 1)

      expected_response = {:error, "invalid parameters"}

      assert response == expected_response
    end

    test "when there is an invalid price returns a error" do
      response = Item.build("description", :pizza, "bana", 1)

      expected_response = {:error, "invalid price"}

      assert response == expected_response
    end

    test "when there is an invalid quantity returns a error" do
      response = Item.build("description", :pizza, "23", 0)

      expected_response = {:error, "invalid parameters"}

      assert response == expected_response
    end
  end
end
