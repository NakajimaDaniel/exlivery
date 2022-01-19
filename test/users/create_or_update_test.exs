defmodule Exlivery.Users.CreateOrUpdateTest do
  use ExUnit.Case

  alias Exlivery.Users.CreateOrUpdate
  alias Exlivery.Users.Agent, as: UserAgent

  import Exlivery.Factory

  describe "call/1" do
    setup do
      UserAgent.start_link(%{})

      :ok
    end

    test "when all params are valid saves the user" do
      params = %{
        name: "name",
        address: "address",
        email: "email@email.com",
        cpf: "123456789",
        age: 20
      }

      response = CreateOrUpdate.call(params)

      expected_response = {:ok, "User created or updated successfully"}

      assert expected_response == response
    end

    test "when there are invalid params, returns a error " do
      params = %{
        name: "name",
        address: "address",
        email: "email@email.com",
        cpf: "123456789",
        age: 10
      }

      response = CreateOrUpdate.call(params)

      expected_response = {:error, "invalid parameters"}

      assert expected_response == response
    end
  end
end
