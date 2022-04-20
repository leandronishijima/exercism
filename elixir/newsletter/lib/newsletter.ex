defmodule Newsletter do
  def read_emails(path) do
    {:ok, binary} = File.read(path)

    String.split(binary, "\n", trim: true)
  end

  def open_log(path), do: File.open!(path, [:write])

  def log_sent_email(pid, email), do: IO.puts(pid, email)

  def close_log(pid), do: File.close(pid)

  def send_newsletter(emails_path, log_path, send_fun) do
    log_file_pid = open_log(log_path)

    emails_path
    |> read_emails()
    |> Enum.each(&(send_fun.(&1) == :ok and log_sent_email(log_file_pid, &1)))

    close_log(log_file_pid)
  end
end
