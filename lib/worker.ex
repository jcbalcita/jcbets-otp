defmodule JcbetsOtp.Worker do
  use GenServer

  @http_caller Application.get_env(:jcbets_otp, :http_caller)

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

  def stop(pid) do
    GenServer.cast(pid, :stop)
  end

  # Server API

  def handle_call({:record, manager}, _from, stats) do
    case @http_caller.fetch_record(manager) do
      {:ok, manager_map} ->
        new_stats = update_stats(stats, manager_map)
        {:reply, manager_map, new_stats}
      _ ->
        {:reply, "Unable to fetch stats for this manager", stats}
    end
  end

  def handle_call(:get_stats, _from, stats) do
    {:reply, stats, stats}
  end

  def handle_cast(:stop, stats) do
    {:stop, :normal, stats}
  end


  # Server Callbacks

  def init(:ok) do
    {:ok, %{}}
  end


  # Helper functions

  defp update_stats(stats, %{"name" => name, "record" => record}) do
    case Map.has_key?(stats, name) do
      true -> stats
      false -> Map.put(stats, name, record)
    end
  end

end
