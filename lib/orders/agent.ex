defmodule Exlivery.Orders.Agent do
  alias Exlivery.Orders.Order

  use Agent

  def start_link(_initial) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def save(%Order{} = order) do
    uuid = UUID.uuid4()
    Agent.update(__MODULE__, fn x -> update_state(x, order, uuid) end)
    {:ok, uuid}
  end

  def get(uuid), do: Agent.get(__MODULE__, fn x -> get_order(x, uuid) end)

  def list_all, do: Agent.get(__MODULE__, fn x -> x end)

  defp update_state(state, %Order{} = order, uuid), do: Map.put(state, uuid, order)

  defp get_order(state, uuid) do
    case Map.get(state, uuid) do
      nil -> {:error, "order not found"}
      order -> {:ok, order}
    end
  end
end
