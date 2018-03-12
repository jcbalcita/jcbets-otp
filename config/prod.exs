use Mix.Config

config :jcbets_otp, :http_caller, JcbetsOtp.HttpCaller


config :jcbets_otp, :psql_username, System.get_env("PSQL_USERNAME")
config :jcbets_otp, :psql_password, System.get_env("PSQL_PASSWORD")
config :jcbets_otp, :hostname, System.get_env("PSQL_HOSTNAME")