defmodule JcbetsWorkerTest do
  use ExUnit.Case
  alias JcbetsOtp.Worker
  doctest Worker

  setup do
    {:ok, process} = Worker.start_link

    on_exit fn ->
      Worker.stop(process)
    end

    {:ok, process: process}
  end

  test "" do
    # given

    # when

    # then
    assert true
  end


end
