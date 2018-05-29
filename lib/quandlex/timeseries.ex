defmodule Quandlex.Timeseries do
  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://www.quandl.com/api/v3"
  plug Tesla.Middleware.JSON

  def get_data(database_code, dataset_code) do
    call("/datasets/#{database_code}/#{dataset_code}/data.json")
  end

  def get_database_metadata(database_code) do
    call("/databases/#{database_code}.json")
  end

  def get_dataset_metadata(database_code, dataset_code) do
    call("/datasets/#{database_code}/#{dataset_code}/metadata.json")
  end

  def call(url) do
    with {:ok, tesla_env} <- get(url) do
      {:ok, tesla_env.body}
    else
      err -> err
    end
  end
end
