defmodule Exlivery.Factory do
  use ExMachina

  alias Exlivery.Users.User
  alias Exlivery.Orders.{Item, Order}

  def user_factory do
    %User{
      name: "Alfonse",
      email: "alfonse@mail.com",
      cpf: "12345677",
      age: 76,
      address: "Baker St."
    }
  end

  def item_factory do
    %Item{
      category: :pizza,
      description: "Pizza",
      quantity: 1,
      unity_price: Decimal.new("35.5")
    }
  end

  def order_factory do
    {:ok,
     %Exlivery.Orders.Order{
       delivery_address: "Baker St.",
       items: [
         %Exlivery.Orders.Item{
           category: :pizza,
           description: "Pizza",
           quantity: 1,
           unity_price: Decimal.new("35.50")
         },
         %Exlivery.Orders.Item{
           category: :japonesa,
           description: "Temaki",
           quantity: 2,
           unity_price: Decimal.new("20.50")
         }
       ],
       total_price: Decimal.new("76.50"),
       user_cpf: "12345677"
     }}
  end
end
