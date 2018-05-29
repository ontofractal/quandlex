defmodule Quandlex.Forex.Pairs do
  def symbols_for("BOE", "GBP") do
    ~w(AUD CAD CNY CZK DKK HKD HUF INR NIS JPY LTL MYR NZD NOK PLN GBP RUB SAR SGD ZAR KRW SEK CHF TWD THB TRY)
  end

  def symbols_for("FRED", "USD") do
    ~w(AUD BRL GBP CAD CNY DKK EUR HKD INR JPY MYR MXN TWD NZD NOK SGD ZAR KRW LKR SEK CHF THB VEF)
  end

  def symbols_for("ECB", "EUR") do
    ~w(AUD BGN BRL CAD CHF CNY CZK DKK GBP HKD HRK HUF IDR ILS INR ISK JPY KRW LTL MXN MYR NOK NZD PHP PLN RON RUB SEK SGD THB TRY USD ZAR )
  end
end
