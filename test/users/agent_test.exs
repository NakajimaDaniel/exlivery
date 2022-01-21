defmodule Exlivery.Users.AgentTest do
  use ExUnit.Case
  alias Exlivery.Users.Agent, as: UserAgent

  import Exlivery.Factory

  describe "save/1" do
    test "Saves the user" do
      user = build(:user)

      UserAgent.start_link(%{})

      assert UserAgent.save(user) == :ok
    end
  end

  describe "get/1" do
    setup do
      UserAgent.start_link(%{})
      cpf = "123456789"
      {:ok, cpf: cpf}
    end

    test "when user if found, returns the user", %{cpf: cpf} do
      user = build(:user, cpf: cpf)

      UserAgent.save(user)

      response = UserAgent.get(cpf)

      expected_response = {:ok, %Exlivery.Users.User{address: "address", age: 22, cpf: "123456789", email: "email", name: "name"}}

      assert expected_response == response
    end

    test "when the user is not found, returns an error" do
      response = UserAgent.get("0000000")

      expected_response = {:error, "user not found"}

      assert expected_response == response
    end
  end
end
