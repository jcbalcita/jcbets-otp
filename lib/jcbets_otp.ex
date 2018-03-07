defmodule JcbetsOtp do
  alias JcbetsOtp.Worker

  def hello do
    {:ok, process} = Worker.start_link
    ["jc", "lafer"] |> Enum.each(fn m -> Worker.get_record process, m end)
    stats = Worker.get_stats(process)
    Worker.stop()
    stats
  end
end
