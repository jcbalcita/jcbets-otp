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
    # given
    non_existent_manager = "whoami"
    expected_response = {:error, "Unable to fetch stats for this manager"}

    # when
    actual = Worker.get_record(process, non_existent_manager)

    # then
    assert(expected_response == actual)
  end

  test "returns map tuple if manager exists", %{process: process} do
    # given
    existing_manager = "lafer"
    expected_response =   %{
      "id" => 2,
      "mer" => "-169.46",
      "name" => "lafer",
      "podium_score" => 14,
      "podiums" => [1, 3, 0],
      "points" => "20738.87",
      "record" => [99, 113, 0],
      "seasons" => 16
    }

    # when
    actual = Worker.get_record(process, existing_manager)

    # then
    assert(expected_response == actual)
  end

end
