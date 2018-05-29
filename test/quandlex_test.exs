defmodule QuandlexTest do
  use ExUnit.Case
  doctest Quandlex

  test "get timeseries" do
    assert %{"dataset_data" => %{"data" => data, "start_date" => _}} =
             Quandlex.Client.timeseries("BOE", "XUDLJYS")
  end

  test "get timeseries with metadata" do
    assert %{"dataset" => %{"column_names" => _, "dataset_code" => _}} =
             Quandlex.Client.timeseries("BOE", "XUDLJYS", metadata: true)
  end

  test "get database metadata" do
    assert %{"database" => %{"database_code" => data, "id" => _}} =
             Quandlex.Client.timeseries("BOE", "XUDLJYS", metadata: :database)
  end
end
