defmodule JcbetsOtpTest do
  use ExUnit.Case
  doctest JcbetsOtp

  test "returns stats for the managers passed in" do
    # given
    managers = ["jc", "lafer"]

    # when
    actual = JcbetsOtp.get_all_time_record_for(managers)
    expected = %{"jc" => [118, 81, 0], "lafer" => [99, 113, 0]}

    # then
    assert(expected == actual)
  end


end
