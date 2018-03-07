defmodule JcbetsOtpTest do
  use ExUnit.Case
  doctest JcbetsOtp

  test "greets the world" do
    assert JcbetsOtp.hello() == %{"jc" => [118, 81, 0], "lafer" => [99, 113, 0]}
  end
end
