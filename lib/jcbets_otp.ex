defmodule JcbetsOtp do
  alias JcbetsOtp.Worker

  def hello do
    {:ok, pid} = Worker.start_link
    Worker.get_record(pid, "jc")
    Worker.get_record(pid, "lafer")
    Worker.get_stats(pid)
  end
end
