defmodule Quandlex.ForexTest do
  use ExUnit.Case
  doctest Quandlex

  test "get historical forex data for BOE for HKD in USD " do
    assert %{"dataset_data" => %{"data" => _, "start_date" => _}} =
             Quandlex.Forex.get_all_daily("HKD", "USD", source:  "BOE" )
  end
end
