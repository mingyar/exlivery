defmodule Exlivery.Orders.OrderTest do
  use ExUnit.Case
  alias Exlivery.Orders.Order
  import Exlivery.Factory

  describe "build/2" do
    test "when all params are valid, return an order" do
      user = build(:user)

      items = [
        build(:item),
        build(:item,
          description: "Temaki",
          category: :japonesa,
          quantity: 2,
          unity_price: Decimal.new("20.50")
        )
      ]

      response = Order.build(user, items)

      expected_response = ""
      assert response == expected_response
    end

    test "when there is invalid category, returns an error" do
      response =
        Item.build(
          "Pizza",
          :random,
          35.5,
          1
        )

      expected_response = {:error, "Invalid parameters"}
      assert response == expected_response
    end
  end
end
