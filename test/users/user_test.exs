defmodule Exlivery.Users.UserTest do
  use ExUnit.Case

  alias Exlivery.Users.User

  describe "build/5" do
    test "when all params are valid, returns user" do
      response = User.build("name", "email", "222", 22, "address")

      expected_response =
        {:ok,
         %Exlivery.Users.User{
           address: "address",
           age: 22,
           cpf: "222",
           email: "email",
           name: "name"
         }}

      assert expected_response == response
    end

    test "when there are invalid params returns a error" do
      response = User.build("name", "email", "222", 10, "address")

      expected_response = {:error, "invalid parameters"}

      assert expected_response == response
    end
  end
end
