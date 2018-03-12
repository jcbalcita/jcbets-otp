defmodule DBConnTest do
  use ExUnit.Case
  alias JcbetsOtp.DBConn
  doctest DBConn

  setup do
    {:ok, process} = DBConn.start_link

    on_exit fn ->
      if Process.alive?(process), do: DBConn.stop(process)
    end

    {:ok, process: process}
  end

  test "can query the database", %{process: process} do
    # WHEN
    {:ok, managers_result} = Postgrex.query(process, "select * from vgl_managers", [])

    # THEN
    assert(result.num_rows == 18)
  end

end