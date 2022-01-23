defmodule Exlivery.Orders.ReportTest do
  use ExUnit.Case

  alias Exlivery.Orders.Agent, as: OrderAgent
  alias Exlivery.Orders.Report

  import Exlivery.Factory

  describe "create/1" do
    test "creates the report file" do
      OrderAgent.start_link(%{})

      :order
      |> build()
      |> OrderAgent.save()

      :order
      |> build()
      |> OrderAgent.save()

      expected_response =
      "222,pizza,1,23japonesa,1,23,46.00\n" <>
      "222,pizza,1,23japonesa,1,23,46.00\n"
      
      Report.create("report_test.csv")

      response = File.read!("report_test.csv")

      assert expected_response == response

    end
  end

end