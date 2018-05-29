defmodule Quandlex.Client do
  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://www.quandl.com/api/v3"
  plug Tesla.Middleware.JSON

  def timeseries(database_code, dataset_code, return_format \\ "json") do
    with {:ok, tesla_env} <-
           get("/datasets/#{database_code}/#{dataset_code}/data.#{return_format}") do
      tesla_env.body
    else
      err -> err
    end
  end
end
