defmodule BankAccount do
  @moduledoc """
  A bank account that supports access from multiple processes.
  """

  @typedoc """
  An account handle.
  """
  @opaque account :: pid

  @doc """
  Open the bank account, making it available for further operations.
  """
  @spec open() :: account
  def open() do
    {:ok, account} = Agent.start(fn -> 0 end)

    account
  end

  @doc """
  Close the bank account, making it unavailable for further operations.
  """
  @spec close(account) :: any
  def close(account) do
    Agent.update(account, fn _ -> :account_closed end)
  end

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer | {:error, :account_closed}
  def balance(account) do
    case Agent.get(account, fn state -> state end) do
      balance when is_integer(balance) -> balance
      _ -> {:error, :account_closed}
    end
  end

  @doc """
  Add the given amount to the account's balance.
  """
  @spec deposit(account, integer) :: :ok | {:error, :account_closed | :amount_must_be_positive}
  def deposit(_account, amount) when amount < 0 do
    {:error, :amount_must_be_positive}
  end

  def deposit(account, amount) do
    case Agent.get_and_update(account, fn
           :account_closed ->
             {:account_closed, :account_closed}

           current_balance ->
             {current_balance, current_balance + amount}
         end) do
      :account_closed -> {:error, :account_closed}
      _ -> :ok
    end
  end

  @doc """
  Subtract the given amount from the account's balance.
  """
  @spec withdraw(account, integer) ::
          :ok | {:error, :account_closed | :amount_must_be_positive | :not_enough_balance}
  def withdraw(_, amount) when amount < 0 do
    {:error, :amount_must_be_positive}
  end

  def withdraw(account, amount) do
    case Agent.get(account, fn state -> state end) do
      :account_closed ->
        {:error, :account_closed}

      current_balance when current_balance < amount ->
        {:error, :not_enough_balance}

      _ ->
        Agent.cast(account, fn state -> state - amount end)
    end
  end
end
