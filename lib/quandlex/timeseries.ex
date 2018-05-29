defmodule Quandlex.Timeseries do
  use Tesla

  @api_key Application.get_env(:quandlex, :api_key)

  plug Tesla.Middleware.BaseUrl, "https://www.quandl.com/api/v3"
  plug Tesla.Middleware.JSON

  def get_data(database_code, dataset_code) do
    call("/datasets/#{database_code}/#{dataset_code}/data.json", "dataset_data")
  end

  def get_data(database_code, dataset_code, query) when is_map(query) do
    call("/datasets/#{database_code}/#{dataset_code}/data.json", "dataset_data", query)
  end

  def get_database_metadata(database_code) do
    call("/databases/#{database_code}.json", "database")
  end

  def get_dataset_metadata(database_code, dataset_code) do
    call("/datasets/#{database_code}/#{dataset_code}/metadata.json", "dataset")
  end

  def call(url, field_to_unwrap, query \\ %{}) do
    query =
      if @api_key do
        Map.merge(query, %{api_key: @api_key})
      else
        query
      end

    query_list = Enum.into(query, Keyword.new())

    with {:ok, tesla_env} <- get(url, query: query_list),
         nil <- tesla_env.body["quandl_error"],
         response <- tesla_env.body[field_to_unwrap] do
      {:ok, response}
    else
      err when is_map(err) -> {:error, err}
      err -> err
    end
  end
end
