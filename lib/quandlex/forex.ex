defmodule Quandlex.Forex do
  @moduledoc """
  Utility module to query historical data for foreign exchange rates using Quandl free APIs
  """


  def get_all_daily(from, to, opts = [source: source]) do
    symbol = generate_symbol(from, to, opts)
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

  def generate_symbol(from, to, source: "ECB") do
    case {from, to} do
      {"AUD", "EUR"} -> "EURAUD"
      {"BGN", "EUR"} -> "EURBGN"
      {"BRL", "EUR"} -> "EURBRL"
      {"CAD", "EUR"} -> "EURCAD"
      {"CHF", "EUR"} -> "EURCHF"
      {"CNY", "EUR"} -> "EURCNY"
      {"CZK", "EUR"} -> "EURCZK"
      {"DKK", "EUR"} -> "EURDKK"
      {"GBP", "EUR"} -> "EURGBP"
      {"HKD", "EUR"} -> "EURHKD"
      {"HRK", "EUR"} -> "EURHRK"
      {"HUF", "EUR"} -> "EURHUF"
      {"IDR", "EUR"} -> "EURIDR"
      {"ILS", "EUR"} -> "EURILS"
      {"INR", "EUR"} -> "EURINR"
      {"ISK", "EUR"} -> "EURISK"
      {"JPY", "EUR"} -> "EURJPY"
      {"KRW", "EUR"} -> "EURKRW"
      {"LTL", "EUR"} -> "EURLTL"
      {"MXN", "EUR"} -> "EURMXN"
      {"MYR", "EUR"} -> "EURMYR"
      {"NOK", "EUR"} -> "EURNOK"
      {"NZD", "EUR"} -> "EURNZD"
      {"PHP", "EUR"} -> "EURPHP"
      {"PLN", "EUR"} -> "EURPLN"
      {"RON", "EUR"} -> "EURRON"
      {"RUB", "EUR"} -> "EURRUB"
      {"SEK", "EUR"} -> "EURSEK"
      {"SGD", "EUR"} -> "EURSGD"
      {"THB", "EUR"} -> "EURTHB"
      {"TRY", "EUR"} -> "EURTRY"
      {"USD", "EUR"} -> "EURUSD"
      {"ZAR", "EUR"} -> "EURZAR"
    end
  end
end
