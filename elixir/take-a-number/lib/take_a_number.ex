defmodule TakeANumber do
  def start() do
    spawn(fn -> machine_state(0) end)
  end

  defp machine_state(state) do
    state =
      receive do
        {:report_state, sender_pid} ->
          send(sender_pid, state)
          state

        {:take_a_number, sender_pid} ->
          state = state + 1
          send(sender_pid, state)
          state

        :stop ->
          exit(:exit)

        _ ->
          state
      end

    machine_state(state)
  end
end
