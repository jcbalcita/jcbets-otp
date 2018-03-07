defmodule JcbetsOtp.HttpCaller do

  @spec fetch_record(String.t()) :: list(integer)
  def fetch_record(manager) do
    base_url() <> manager
    |> HTTPoison.get()
    |> parse_response
  end

  defp parse_response({:ok, %HTTPoison.Response{body: body, status_code: 200}}) do
    body |> Poison.decode!() |> compute_record
  end

  defp parse_response(_), do: :error

  defp compute_record(json) do
    {:ok, {json["name"], json["record"]}}
  end

  defp base_url, do: "http://ec2-54-245-62-121.us-west-2.compute.amazonaws.com/api/vgl/manager/"
end