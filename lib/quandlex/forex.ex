defmodule Quandlex.Forex do
  @moduledoc """
  Utility module to query historical data for foreign exchange rates using Quandl free APIs
  """
  defdelegate symbols_for(dataset_code, to_currency), to: Quandlex.Forex.Pairs

  @doc ~S"""
  Returns all available timeseries for given base and quote currency. Timeseries source dataset is automatically selected based on the quote currency if options [source: "SOURCE"] arg is not passed.

  ## Examples

      iex> {:ok, %{data: data, type: type, database_code: database_code}} = Quandlex.Forex.get_rates("HKD", "USD")
      iex> database_code === "FRED" and is_list(data) and type == "Time Series"
      true

      iex> {:ok, %{data: data, type: type, database_code: database_code}} = Quandlex.Forex.get_rates("HKD", "USD", source: "BOE")
      iex> database_code === "BOE" and is_list(data) and type == "Time Series"
      true

      iex> {:ok, %{data: data, type: type, database_code: database_code}} = Quandlex.Forex.get_rates("THB", "EUR", source: "ECB")
      iex> database_code === "ECB" and is_list(data) and type == "Time Series"
      true




  ## Response example

  {:ok,
  %{
   collapse: nil,
   column_index: nil,
   column_names: ["Date", "Value"],
   data: [
     [~D[2018-05-18], 7.8498],
     [~D[2018-05-17], 7.8496],
     [~D[2018-05-16], 7.8499],
     [...],
     ...
   ],
   database_code: "FRED",
   database_id: 118,
   dataset_code: "DEXHKUS",
   description: "Hong Kong Dollars to One U.S. Dollar Not Seasonally Adjusted, Noon buying rates in New York City for cable transfers payable in foreign currencies. ",
   end_date: "2018-05-18",
   frequency: "daily",
   id: 121063,
   limit: nil,
   name: "Hong Kong / U.S. Foreign Exchange Rate",
   newest_available_date: "2018-05-18",
   oldest_available_date: "1981-01-02",
   order: nil,
   premium: false,
   refreshed_at: "2018-05-27T03:10:46.002Z",
   start_date: "1981-01-02",
   transform: nil,
   type: "Time Series"
  }}
  """

  def get_rates(from, "USD"), do: get_rates(from, "USD", source: "FRED")
  def get_rates(from, "EUR"), do: get_rates(from, "EUR", source: "ECB")
  def get_rates(from, "GBP"), do: get_rates(from, "GBP", source: "BOE")

  def get_rates(from, to, opts = [source: source]) do
    symbol = generate_symbol(from, to, opts)
    Quandlex.Timeseries.get_data(source, symbol)
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
