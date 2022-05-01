# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(opts \\ %{next_id: 1, plots: []}),
    do: Agent.start(fn -> opts end)

  def list_registrations(pid),
    do: Agent.get(pid, fn %{plots: plots} -> plots end)

  def register(pid, register_to) do
    Agent.get_and_update(
      pid,
      fn %{next_id: id, plots: plots} ->
        new_plot = %Plot{plot_id: id, registered_to: register_to}

        {new_plot, %{next_id: id + 1, plots: plots ++ [new_plot]}}
      end
    )
  end

  def release(pid, plot_id) do
    Agent.get_and_update(
      pid,
      fn %{plots: plots} = state ->
        plot_found = find_plot_by_id(plots, plot_id)

        if is_nil(plot_found),
          do: {:ok, state},
          else: {:ok, %{state | plots: plots -- [plot_found]}}
      end
    )
  end

  def get_registration(pid, plot_id) do
    Agent.get(pid, fn %{plots: plots} ->
      found = find_plot_by_id(plots, plot_id)

      if is_nil(found),
        do: {:not_found, "plot is unregistered"},
        else: found
    end)
  end

  defp find_plot_by_id(plots, id),
    do: Enum.find(plots, &(&1.plot_id == id))
end
