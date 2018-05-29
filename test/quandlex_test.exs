defmodule QuandlexTest do
  use ExUnit.Case
  doctest Quandlex

  test "get timeseries" do
    assert {:ok, %{"dataset_data" => %{"data" => data, "start_date" => _}}} =
             Quandlex.Timeseries.get_data("BOE", "XUDLJYS")
  end

  test "get timeseries with metadata" do
    assert {:ok, %{"dataset" => %{"column_names" => _, "dataset_code" => _}}} =
             Quandlex.Timeseries.get_dataset_metadata("BOE", "XUDLJYS")
  end

  test "get database metadata" do
    assert {:ok, %{"database" => %{"database_code" => data, "id" => _}}} =
             Quandlex.Timeseries.get_database_metadata("BOE")
  end
end
