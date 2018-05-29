defmodule Quandlex.Client do
  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://www.quandl.com/api/v3"
  plug Tesla.Middleware.JSON

  def timeseries(database_code, dataset_code, opts \\ [format: "json"])

  def timeseries(database_code, dataset_code, metadata: true) do
    call("/datasets/#{database_code}/#{dataset_code}/metadata.json")
  end

  def timeseries(database_code, _dataset_code, metadata: :database) do
    call("/databases/#{database_code}.json")
  end

  def timeseries(database_code, dataset_code, format: "json") do
    call("/datasets/#{database_code}/#{dataset_code}/data.json")
  end

  def call(url) do
    with {:ok, tesla_env} <- get(url) do
      tesla_env.body
    else
      err -> err
    end
  end
end
