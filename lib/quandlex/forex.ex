defmodule Quandlex.Forex do
  @moduledoc """
  Utility module to query historical data for foreign exchange rates using Quandl free APIs
  """
  defdelegate symbols_for(dataset_code, to_currency), to: Quandlex.Forex.Pairs

  def all(from, "USD"), do: get_all_daily(from, "USD", source: "FRED")
  def all(from, "EUR"), do: get_all_daily(from, "EUR", source: "ECB")
  def all(from, "GBP"), do: get_all_daily(from, "GBP", source: "BOE")

  def get_all_daily(from, to, opts = [source: source]) do
    symbol = generate_symbol(from, to, opts)
    Quandlex.Client.timeseries(source, symbol)
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

  def generate_symbol(from, to, source: "BOE") do
    case to do
      "USD" ->
        case from do
          "AUD" -> "XUDLADD"
          "CAD" -> "XUDLCDD"
          "CNY" -> "XUDLBK73"
          "CZK" -> "XUDLBK27"
          "DKK" -> "XUDLDKD"
          "HKD" -> "XUDLHDD"
          "HUF" -> "XUDLBK35"
          "INR" -> "XUDLBK64"
          "NIS" -> "XUDLBK65"
          "JPY" -> "XUDLJYD"
          "LTL" -> "XUDLBK38"
          "MYR" -> "XUDLBK66"
          "NZD" -> "XUDLNDD"
          "NOK" -> "XUDLNKD"
          "PLN" -> "XUDLBK49"
          "GBP" -> "XUDLGBD"
          "RUB" -> "XUDLBK69"
          "SAR" -> "XUDLSRD"
          "SGD" -> "XUDLSGD"
          "ZAR" -> "XUDLZRD"
          "KRW" -> "XUDLBK74"
          "SEK" -> "XUDLSKD"
          "CHF" -> "XUDLSFD"
          "TWD" -> "XUDLTWD"
          "THB" -> "XUDLBK72"
          "TRY" -> "XUDLBK75"
        end

      "GBP" ->
        case from do
          "AUD" -> "XUDLADS"
          "CAD" -> "XUDLCDS"
          "CNY" -> "XUDLBK89"
          "CZK" -> "XUDLBK25"
          "DKK" -> "XUDLDKS"
          "HKD" -> "XUDLHDS"
          "HUF" -> "XUDLBK33"
          "INR" -> "XUDLBK97"
          "NIS" -> "XUDLBK78"
          "JPY" -> "XUDLJYS"
          "LTL" -> "XUDLBK36"
          "MYR" -> "XUDLBK83"
          "NZD" -> "XUDLNDS"
          "NOK" -> "XUDLNKS"
          "PLN" -> "XUDLBK47"
          "GBP" -> "XUDLGBG"
          "RUB" -> "XUDLBK85"
          "SAR" -> "XUDLSRS"
          "SGD" -> "XUDLSGS"
          "ZAR" -> "XUDLZRS"
          "KRW" -> "XUDLBK93"
          "SEK" -> "XUDLSKS"
          "CHF" -> "XUDLSFS"
          "TWD" -> "XUDLTWS"
          "THB" -> "XUDLBK87"
          "TRY" -> "XUDLBK95"
        end

      "EUR" ->
        case from do
          "CZK" -> "XUDLBK26"
          "DKK" -> "XUDLBK76"
          "HUF" -> "XUDLBK34"
          "JPY" -> "XUDLBK63"
          "LTL" -> "XUDLBK37"
          "PLN" -> "XUDLBK48"
          "GBP" -> "XUDLSER"
          "CHF" -> "XUDLBK68"
        end
    end
  end
end
