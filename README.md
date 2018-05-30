# Quandlex

An Elixir/Erlang library for Quandl API. Provides easy access to various databases and dataset for financial and market timeseries.


## Installation

The package can be installed by adding `quandlex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:quandlex, "~> 0.1.0"}
  ]
end
```

Documentation including usage examples and return values can be found on [hexdocs](https://hexdocs.pm/quandlex)

## Quandlex.Timeseries

Quandlex.Timeseries includes several functions that match API endpoints:

* `get_data`: returns both data and dataset metadata
* `get_dataset_metadata`: returns only dataset metadata
* `get_database_metadata`: returns database metadata

```
iex> {:ok, %{data: data, type: type}} = Quandlex.Timeseries.get_data("CHRIS", "MGEX_IH1")
iex> is_list(hd(data)) and is_list(data) and type == "Time Series"
true

iex> {:ok, %{name: name, id: id}} = Quandlex.Timeseries.get_database_metadata("CHRIS")
iex> name == "Wiki Continuous Futures" and id == 596
true
```


## Quandlex.Forex

Quandlex.Forex is a utility module that makes fetching historical data of foreign exchange rates simpler and easier.

Quandl provides free (albeit limited for non-registered users) data of forex rates sourced from Bank of England, Federal Reserve and European Central Bank.

[More about Quandle Forex API](https://blog.quandl.com/api-for-currency-data)

You can use get_rates/2 or get_rates/3 function without wasting time on searching for special currency codes for every bank database.

For example, instead of using `Quandlex.Timeseries.get_data("BOE", "XUDLJYD")` you can call `Quandlex.Forex.get_rates("USD", "JPY", source: "BOE")`


### Examples

```
iex> {:ok, %{data: data, type: type, database_code: database_code}} = Quandlex.Forex.get_rates("HKD", "USD")
iex> database_code === "FRED" and is_list(data) and type == "Time Series"
true

iex> {:ok, %{data: data, type: type, database_code: database_code}} = Quandlex.Forex.get_rates("HKD", "USD", source: "BOE")
iex> database_code === "BOE" and is_list(data) and type == "Time Series"
true

iex> {:ok, %{data: data, type: type, database_code: database_code}} = Quandlex.Forex.get_rates("THB", "EUR", source: "ECB")
iex> database_code === "ECB" and is_list(data) and type == "Time Series"
true
```


## Roadmap

* [ ] Add datatables module
* [ ] Add structs for return values
* [ ] Investigate developer experience improvements using rate limiting utilities and caching
