defmodule Quandlex.Forex do
  @moduledoc """
  Utility module to query historical data for foreign exchange rates using Quandl free APIs
  """

  def get_all_daily(from, to, opts = [source: source = "BOE"]) do
    symbol = generate_symbol(from,to, opts)
    Quandlex.Client.timeseries(source, symbol)
  end

  def generate_symbol(from, to, source: "BOE") do
    case {from, to} do
      {"AUD", "USD"} -> "XUDLADD"
      {"AUD", "GBP"} -> "XUDLADS"

      {"CAD", "USD"} -> "XUDLCDD"
      {"CAD", "GBP"} -> "XUDLCDS"

      {"HKD", "USD"} -> "XUDLHDD"
      {"HKD", "GBP"} -> "XUDLHDS"

      {"SGD", "USD"} -> "XUDLSGD"
      {"SGD", "GBP"} -> "XUDLSGS"
    end
  end

end
