defmodule Quandlex.Timeseries do
  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://www.quandl.com/api/v3"
  plug Tesla.Middleware.JSON

  def get_data(database_code, dataset_code) do
    call("/datasets/#{database_code}/#{dataset_code}/data.json", "dataset_data")
  end

  def get_database_metadata(database_code) do
    call("/databases/#{database_code}.json", "database")
  end

  def get_dataset_metadata(database_code, dataset_code) do
    call("/datasets/#{database_code}/#{dataset_code}/metadata.json", "dataset")
  end

  def call(url, field_to_unwrap) do
    with {:ok, tesla_env} <- get(url),
         response <- tesla_env.body[field_to_unwrap] do
      {:ok, response}
    else
      err -> err
    end
  end
end
