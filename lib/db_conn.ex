defmodule JcbetsOtp.DBConn do

  @hostname Application.get_env(:jcbets_otp, :psql_hostname)
  @username Application.get_env(:jcbets_otp, :psql_username)

  def start_link do
    Postgrex.start_link(hostname: @hostname, username: @username, database: "jcbets_dev")
  end

end