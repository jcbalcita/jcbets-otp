defmodule JcbetsOtp do
  alias JcbetsOtp.Worker

  @spec get_all_time_record_for(list(String.t)) :: map
  def get_all_time_record_for(managers) do
    {:ok, process} = Worker.start_link()

    managers |> Enum.each(fn m -> Worker.get_record process, m end)
    Worker.get_stats(process)
  end

end
