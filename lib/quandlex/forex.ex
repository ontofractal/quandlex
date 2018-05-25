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

  def generate_symbol(from, to, source: "FRED") do
    case {from, to} do
      {"AUD", "USD"} -> "DEXUSAL"
      {"BRL", "USD"} -> "DEXBZUS"
      {"GBP", "USD"} -> "DEXUSUK"
      {"CAD", "USD"} -> "DEXCAUS"
      {"CNY", "USD"} -> "DEXCHUS"
      {"DKK", "USD"} -> "DEXDNUS"
      {"EUR", "USD"} -> "DEXUSEU"
      {"HKD", "USD"} -> "DEXHKUS"
      {"INR", "USD"} -> "DEXINUS"
      {"JPY", "USD"} -> "DEXJPUS"
      {"MYR", "USD"} -> "DEXMAUS"
      {"MXN", "USD"} -> "DEXMXUS"
      {"TWD", "USD"} -> "DEXTAUS"
      {"NZD", "USD"} -> "DEXUSNZ"
      {"NOK", "USD"} -> "DEXNOUS"
      {"SGD", "USD"} -> "DEXSIUS"
      {"ZAR", "USD"} -> "DEXSFUS"
      {"KRW", "USD"} -> "DEXKOUS"
      {"LKR", "USD"} -> "DEXSLUS"
      {"SEK", "USD"} -> "DEXSDUS"
      {"CHF", "USD"} -> "DEXSZUS"
      {"THB", "USD"} -> "DEXTHUS"
      {"VEF", "USD"} -> "DEXVZUS"
    end
  end

end
