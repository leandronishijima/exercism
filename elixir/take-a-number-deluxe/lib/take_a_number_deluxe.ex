defmodule TakeANumberDeluxe do
  use GenServer
  # Client API

  @spec start_link(keyword()) :: {:ok, pid()} | {:error, atom()}
  def start_link(init_arg) do
    min = Keyword.get(init_arg, :min_number)
    max = Keyword.get(init_arg, :max_number)

    if validate_args(min, max),
      do: GenServer.start_link(__MODULE__, TakeANumberDeluxe.State.new(min, max)),
      else: {:error, :invalid_configuration}
  end

  defp validate_args(min, max) do
    with true <- min < max,
         true <- is_number(min) and is_number(max) do
      true
    else
      _ ->
        false
    end
  end

  @impl GenServer
  def init(init_arg) do
    {:ok, init_arg}
  end

  @spec report_state(pid()) :: TakeANumberDeluxe.State.t()
  def report_state(machine) do
    {:ok, state} = GenServer.call(machine, :report_state)
    state
  end

  @spec queue_new_number(pid()) :: {:ok, integer()} | {:error, atom()}
  def queue_new_number(machine) do
    case GenServer.call(machine, :queue_new_number) do
      number when is_number(number) ->
        {:ok, number}

      :error ->
        {:error, :all_possible_numbers_are_in_use}
    end
  end

  @spec serve_next_queued_number(pid(), integer() | nil) :: {:ok, integer()} | {:error, atom()}
  def serve_next_queued_number(machine, priority_number \\ nil) do
    result = GenServer.call(machine, {:serve_next_queued_number, priority_number})

    case result do
      {:error, error_msg} ->
        {:error, error_msg}

      number when is_number(number) ->
        {:ok, number}
    end
  end

  @impl GenServer
  def handle_call(:report_state, _from, state) do
    {:reply, state, state}
  end

  @impl GenServer
  def handle_call(:queue_new_number, _from, {:ok, take_a_number} = state) do
    case TakeANumberDeluxe.State.queue_new_number(take_a_number) do
      {:ok, reply, new_state} ->
        {:reply, reply, {:ok, new_state}}

      {:error, _} ->
        {:reply, :error, state}
    end
  end

  @impl GenServer
  def handle_call(
        {:serve_next_queued_number, priority_number},
        _,
        {:ok, take_a_number} = state
      ) do
    result = TakeANumberDeluxe.State.serve_next_queued_number(take_a_number, priority_number)

    case result do
      {:ok, reply, new_state} ->
        {:reply, reply, {:ok, new_state}}

      {:error, error_msg} ->
        {:reply, {:error, error_msg}, state}
    end
  end

  @spec reset_state(pid()) :: :ok
  def reset_state(machine) do
    # Please implement the reset_state/1 function
  end

  # Server callbacks

  # Please implement the necessary callbacks
end
