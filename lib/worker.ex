defmodule JcbetsOtp.Worker do
  use GenServer

  # Client API

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def get_record(pid, manager) do
    GenServer.call(pid, {:record, manager})
  end

  def get_stats(pid) do
    GenServer.call(pid, :get_stats)
  end

  # Server API

  def handle_call({:record, manager}, _from, stats) do
    case fetch_record(manager) do
      {:ok, tuple} ->
        new_stats = update_stats(stats, tuple)
        {:reply, tuple, new_stats}
      _ ->
        {:reply, "Unable to fetch stats for this manager", stats}
    end
  end

  def handle_call(:get_stats, _from, stats) do
    {:reply, stats, stats}
  end

  # Server Callbacks

  def init(:ok) do
    {:ok, %{}}
  end

  # Helper functions

  @spec fetch_record(String.t()) :: list(integer)
  defp fetch_record(manager) do
    base_url() <> manager
    |> HTTPoison.get()
    |> parse_response
  end

  defp parse_response({:ok, %HTTPoison.Response{body: body, status_code: 200}}) do
    body |> Poison.decode!() |> compute_record
  end

  defp parse_response(_), do: :error

  defp compute_record(json) do
    {:ok, {json["name"], json["record"]}}
  end

  defp update_stats(stats, {name, record}) do
    case Map.has_key?(stats, name) do
      true -> stats
      false -> Map.put(stats, name, record)
    end
  end

  defp base_url, do: "http://ec2-54-245-62-121.us-west-2.compute.amazonaws.com/api/vgl/manager/"
end
