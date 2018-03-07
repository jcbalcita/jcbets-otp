defmodule JcbetsOtp.FakeHttpCaller do
  @fake_data %{
    "jc" => %{
      "id" => 1,
      "mer" => "562.95",
      "name" => "jc",
      "podium_score" => 28,
      "podiums" => [5, 1, 0],
      "points" => "19969.09",
      "record" => [118, 81, 0],
      "seasons" => 15
    },
    "lafer" => %{
      "id" => 2,
      "mer" => "-169.46",
      "name" => "lafer",
      "podium_score" => 14,
      "podiums" => [1, 3, 0],
      "points" => "20738.87",
      "record" => [99, 113, 0],
      "seasons" => 16
    }
  }

  @spec fetch_record(String.t()) :: list(integer)
  def fetch_record(manager) do
    {:ok, @fake_data[manager]}
  end

end