defmodule Quandlex.Timeseries do
  use Tesla

  @api_key Application.get_env(:quandlex, :api_key)

  plug Tesla.Middleware.BaseUrl, "https://www.quandl.com/api/v3"
  plug Tesla.Middleware.JSON

  @doc ~S"""
  Returns data and metdata from a specified time-series.

  ## Examples

      iex> {:ok, %{data: data, type: type}} = Quandlex.Timeseries.get_data("CHRIS", "MGEX_IH1")
      iex> is_list(hd(data)) and is_list(data) and type == "Time Series"
      true

  ## Return Examples

    {:ok,
      %{
       collapse: nil,
       column_index: nil,
       column_names: ["Date", "Open", "High", "Low", "Last", "Volume",
        "Open Interest"],
       data: [
         [~D[2019-04-30], nil, 486.0, 486.0, 486.0, 0.0, 0.0],
         [~D[2018-04-30], nil, 486.0, 486.0, 486.0, 0.0, 0.0],
         [~D[2018-04-27], nil, 474.0, 474.0, 474.0, 0.0, 0.0],
         [...],
         ...
       ],
       database_code: "CHRIS",
       database_id: 596,
       dataset_code: "MGEX_IH1",
       description: "Historical Futures Prices: Minneapolis HRWI Hard Red Wheat Futures, Continuous Contract #1. Non-adjusted price based on spot-month continuous contract calculations. Raw data from MGEX.",
       end_date: "2019-04-30",
       frequency: "daily",
       id: 9774107,
       limit: nil,
       name: "Minneapolis HRWI Hard Red Wheat Futures, Continuous Contract #1 (IH1) (Front Month)",
       newest_available_date: "2019-04-30",
       oldest_available_date: "2005-01-03",
       order: nil,
       premium: false,
       refreshed_at: "2018-05-08T18:27:06.846Z",
       start_date: "2005-01-03",
       transform: nil,
       type: "Time Series"
      }}

  """
  def get_data(database_code, dataset_code) do
    call("/datasets/#{database_code}/#{dataset_code}.json", "dataset")
  end

  def get_data(database_code, dataset_code, query) when is_map(query) do
    call("/datasets/#{database_code}/#{dataset_code}.json", "dataset", query)
  end

  @doc ~S"""
  Returns data from a specified time-series.

  ## Examples

      iex> {:ok, %{data: data, type: type}} = Quandlex.Timeseries.get_database_metadata("CHRIS", "MGEX_IH1")
      iex> is_list(hd(data)) and is_list(data) and type == "Time Series"
      true


  ## Response example

  {:ok,
    %{
     database_code: "CHRIS",
     datasets_count: 4047,
     description: "Continuous contracts for all 600 futures on Quandl. Built on top of raw data from CME, ICE, LIFFE etc. Curated by the Quandl community. 50 years history.",
     downloads: 59500176,
     favorite: false,
     id: 596,
     image: "https://quandl-production-data-upload.s3.amazonaws.com/uploads/source/profile_image/596/thumb_wiki-image.png",
     name: "Wiki Continuous Futures",
     premium: false,
     url_name: "Wiki-Continuous-Futures"
    }}
  """
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
      response = AtomicMap.convert(response, %{safe: false})

      response =
        if field_to_unwrap == "dataset" and not (tesla_env.url =~ ~r/metadata.json/) do
          parse_data(response)
        else
          response
        end

      {:ok, response}
    else
      err when is_map(err) -> {:error, err}
      err -> err
    end
  end

  defp parse_data(response) do
    new_data =
      case response.frequency do
        "daily" ->
          for [x | xs] <- response.data, do: [Date.from_iso8601!(x) | xs]

        _ ->
          for [x | xs] <- response.data, do: [NaiveDateTime.from_iso8601!(x) | xs]
      end

    put_in(response.data, new_data)
  end
end
