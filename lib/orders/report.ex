defmodule Exlivery.Orders.Report do
  alias Exlivery.Orders.Agent, as: OrderAgent
  alias Exlivery.Orders.Order
  alias Exlivery.Orders.Item

  def create(filename \\ "report.csv") do
    order_list = build_order_list()

    File.write(filename, order_list)
  end

  defp build_order_list() do
    OrderAgent.start_link(%{})

    OrderAgent.list_all()
    |> Map.values()
    |> Enum.map(&order_string(&1))
  end

  defp order_string(%Order{user_cpf: user_cpf, items: items, total_price: total_price}) do
    items_string = Enum.map(items, &item_string(&1))

    "#{user_cpf},#{items_string},#{total_price}\n"
  end

  defp item_string(%Item{category: category, quantity: quantity, unity_price: unity_price}) do
    "#{category},#{quantity},#{unity_price}"
  end
end