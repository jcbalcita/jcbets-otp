defmodule JcbetsWorkerTest do
  use ExUnit.Case
  alias JcbetsOtp.Worker
  doctest Worker

  setup do
    {:ok, process} = Worker.start_link

    on_exit fn ->
      if Process.alive?(process), do: Worker.stop(process)
    end

    {:ok, process: process}
  end

  test "returns error tuple if manager doesn't exist", %{process: process} do
    # GIVEN
    non_existent_manager = "whoami"
    expected = {:error, "Unable to fetch stats for this manager"}

    # WHEN
    actual = Worker.get_record(process, non_existent_manager)

    # THEN
    assert(expected == actual)
  end

  test "returns map if manager exists", %{process: process} do
    # GIVEN
    existing_manager = "lafer"
    expected =   %{
      "id" => 2,
      "name" => "lafer",
      "points" => "20738.87",
      "record" => [99, 113, 0],
    }

    # WHEN
    actual = Worker.get_record(process, existing_manager)

    # THEN
    assert(expected == actual)
  end

  test "stop/1 gracefully stops the process", %{process: process} do
    assert(:ok == Worker.stop(process))
  end

  test "builds stats after each successful call to get_record/2", %{process: process} do
    # WHEN
    Worker.get_record(process, "lafer")
    Worker.get_record(process, "test")
    Worker.get_record(process, "i don't exist")
    stats = Worker.get_stats(process)

    # THEN
    assert(Map.has_key? stats, "lafer")
    assert(Map.has_key? stats, "test")
    refute(Map.has_key? stats, "i don't exist")
    refute(Map.has_key? stats, "jc")
  end

end
