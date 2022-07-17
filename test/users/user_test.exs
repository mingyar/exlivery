defmodule Exlivery.Users.UserTest do
  use ExUnit.Case
  alias Exlivery.Users.User
  import Exlivery.Factory

  describe "build/5" do
    test "when all params are valid, return the user" do
      response =
        User.build(
          "Baker St.",
          "Alfonse",
          "alfonse@mail.com",
          "12345677",
          76
        )

      expected_response = {:ok, build(:user)}

      assert response == expected_response
    end

    test "when there are invalid params, returns an error" do
      response =
        User.build(
          "Baker St.",
          "August",
          "august@mail.com",
          "123456789",
          12
        )

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end
