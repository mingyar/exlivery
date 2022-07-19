defmodule Exlivery.Orders.ReportTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.Agent, as: OrderAgent
  alias Exlivery.Orders.Report

  describe "create/1" do
    test "creates the report file" do
      OrderAgent.start_link(%{})

      1..2
      |> Enum.map(fn _ ->
        :order
        |> build()
        |> OrderAgent.save()
      end)

      expected_reponse =
        "12345677,pizza,1,35.5japonesa,2,20.50,76.50\n" <>
          "12345677,pizza,1,35.5japonesa,2,20.50,76.50\n"

      Report.create("report_test.csv")

      response  = File.read!("report_test.csv")

      assert response == expected_reponse
    end
  end
end
