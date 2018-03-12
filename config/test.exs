use Mix.Config

config :jcbets_otp, :http_caller, JcbetsOtp.FakeHttpCaller

# PSQL
config :jcbets_otp, :psql_username, "jbalcita"
config :jcbets_otp, :psql_hostname, "localhost"
