defmodule QuandlexTest do
  use ExUnit.Case
  doctest Quandlex

  test "get timeseries" do
    assert %{"dataset_data" => %{"data" => data, "start_date" => _}} =
             Quandlex.Client.timeseries("BOE", "XUDLJYS", "json")
  end
end