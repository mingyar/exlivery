defmodule Exlivery.Orders.Order do
  alias Exlivery.Users.User
  alias Exlivery.Orders.Item

  @keys [:user_cpf, :delivery_address, :items, :total_price]
  @enforce_keys @keys

  defstruct @keys

  def build(%User{cpf: cpf, address: address}, [%Item{} | _items] = items) do
    {:ok,
     %__MODULE__{
       user_cpf: cpf,
       delivery_address: address,
       items: items,
       total_price: calculate_total_price(items)
     }}
  end

  def build(_, _), do: {:error, "Invalid parameters"}

  defp calculate_total_price(items) do
    items
    |> Enum.reduce(Decimal.new("0.00"), &sum_prices(&1, &2))
  end

  def sum_prices(%Item{unity_price: unity_price, quantity: quantity}, acc) do
    unity_price
    |> Decimal.mult(quantity)
    |> Decimal.add(acc)
  end
end
