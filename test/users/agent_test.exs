defmodule Exlivery.Users.AgentTest do
  use ExUnit.Case
  import Exlivery.Factory
  alias Exlivery.Users.User
  alias Exlivery.Users.Agent, as: UserAgent

  describe "save/1" do
    test "saves the user" do
      user = build(:user)

      UserAgent.start_link(%{})

      assert UserAgent.save(user) == :ok
    end
  end

  describe "get/1" do
    setup do
      UserAgent.start_link(%{})

      :ok
    end

    test "when the user is found, returns the user" do
      :user
      |> build(cpf: "1234567")
      |> UserAgent.save()

      response = UserAgent.get("1234567")

      expected_response =
        {:ok,
         %User{
           address: "Baker St.",
           age: 76,
           cpf: "1234567",
           email: "alfonse@mail.com",
           name: "Alfonse"
         }}

      assert response == expected_response
    end

    test "when the user is not found, returns an error" do
      response = UserAgent.get("0000000")

      expected_response = {:error, "User not found"}

      assert response == expected_response
    end
  end
end
