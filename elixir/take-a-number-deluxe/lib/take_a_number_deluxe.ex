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

  @impl GenServer
  def handle_call(:report_state, _from, state) do
    {:reply, state, state}
  end

  @spec queue_new_number(pid()) :: {:ok, integer()} | {:error, atom()}
  def queue_new_number(machine) do
    # Please implement the queue_new_number/1 function
  end

  @spec serve_next_queued_number(pid(), integer() | nil) :: {:ok, integer()} | {:error, atom()}
  def serve_next_queued_number(machine, priority_number \\ nil) do
    # Please implement the serve_next_queued_number/2 function
  end

  @spec reset_state(pid()) :: :ok
  def reset_state(machine) do
    # Please implement the reset_state/1 function
  end

  # Server callbacks

  # Please implement the necessary callbacks
end
