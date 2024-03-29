defmodule Exlivery.Orders.CreateOrUpdate do
  alias Exlivery.Orders.Agent, as: OrderAgent
  alias Exlivery.Orders.Item
  alias Exlivery.Orders.Order

  alias Exlivery.Users.Agent, as: UserAgent

  def call(%{user_cpf: user_cpf, items: items}) do
    with {:ok, user} <- UserAgent.get(user_cpf),
         {:ok, items} <- build_items(items),
         {:ok, order} <- Order.build(user, items) do
      OrderAgent.save(order)
    else
      error -> error
    end
  end

  defp build_items(items) do
    items
    |> Enum.map(fn x -> build_item(x) end)
    |> handle_build()
  end

  defp build_item(%{
         description: description,
         category: category,
         unit_price: unit_price,
         quantity: quantity
       }) do
    case Item.build(description, category, unit_price, quantity) do
      {:ok, item} -> item
      {:error, _reason} = error -> error
    end
  end

  defp handle_build(items) do
    if Enum.all?(items, fn x -> is_struct(x) end),
      do: {:ok, items},
      else: {:error, "Invalid Items"}
  end
end
