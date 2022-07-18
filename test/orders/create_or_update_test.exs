defmodule Exlivery.Orders.CreateOrUpdateTest do
  use ExUnit.Case
  import Exlivery.Factory
  alias Exlivery.Orders.CreateOrUpdate
  alias Exlivery.Users.Agent, as: UserAgent

  describe "call/1" do
    setup do
      Exlivery.start_agents()

      cpf = "3434242342"
      user = build(:user, cpf: cpf)

      UserAgent.save(user)

      item1 = %{
        category: :pizza,
        description: "Pizza",
        quantity: 1,
        unity_price: "35.50"
      }

      item2 = %{
        category: :pizza,
        description: "Pizza",
        quantity: 1,
        unity_price: "31.50"
      }

      {:ok, user_cpf: cpf, item1: item1, item2: item2}
    end

    test "when all params are valid, save the order", %{user_cpf: cpf, item1: item1, item2: item2} do
      params = %{
        user_cpf: cpf,
        items: [item1, item2]
      }

      response = CreateOrUpdate.call(params)

      assert {:ok, _uuid} = response
    end

    test "when there is no user with given cpf, returns an error", %{item1: item1, item2: item2} do
      params = %{
        user_cpf: "00000000",
        items: [item1, item2]
      }

      expected_response = {:error, "User not found"}

      response = CreateOrUpdate.call(params)

      assert expected_response == response
    end

    test "when there are invalid items, returns an error", %{
      user_cpf: cpf,
      item1: item1,
      item2: item2
    } do
      params = %{
        user_cpf: cpf,
        items: [%{item1 | quantity: 0}, item2]
      }

      expected_response = {:error, "Invalid items"}

      response = CreateOrUpdate.call(params)

      assert expected_response == response
    end

    test "when there are no items, returns an error", %{user_cpf: cpf} do
      params = %{
        user_cpf: cpf,
        items: []
      }

      expected_response = {:error, "Invalid parameters"}

      response = CreateOrUpdate.call(params)

      assert expected_response == response
    end
  end
end
