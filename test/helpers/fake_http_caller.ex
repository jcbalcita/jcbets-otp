defmodule JcbetsOtp.FakeHttpCaller do
  @fake_data %{
    "jc" => %{
      "id" => 1,
      "name" => "jc",
      "points" => "19969.09",
      "record" => [118, 81, 0],
    },
    "lafer" => %{
      "id" => 2,
      "name" => "lafer",
      "points" => "20738.87",
      "record" => [99, 113, 0],
    },
    "test" => %{
      "id" => 3,
      "name" => "test",
      "points" => "200000.69",
      "record" => [1337, 0, 0],
    }
  }

  @spec fetch_record(String.t()) :: list(integer)
  def fetch_record(manager) do
    case @fake_data[manager] do
      nil -> {:error, "Unable to fetch stats for this manager"}
      _   -> {:ok, @fake_data[manager]}
    end
  end

end