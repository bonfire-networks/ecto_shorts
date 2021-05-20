defmodule EctoShorts do
  @moduledoc """
  Ecto Shorts is a library created to help shorten ecto queries


  Common filters available include:

  - `preload` - Preloads fields onto the query results
  - `start_date` - Query for items inserted after this date
  - `end_date` - Query for items inserted before this date
  - `before` - Get items with IDs before this value
  - `after` - Get items with IDs after this value
  - `ids` - Get items with a list of ids
  - `first` - Gets the first n items
  - `last` - Gets the last n items
  - `limit` - Gets the first n items
  - `offset` - Offsets limit by n items
  - `search` - ***Warning:*** This requires schemas using this to have a `&by_search(query, val)` function
  - `join_preload` - WIP: Joins an associations and preloads its fields onto the query results (using only one query)

  You are also able to filter on any natural field of a model, as well as use

  - gte/gt
  - lte/lt
  - like/ilike
  - is_nil/not(is_nil)

  ```elixir
  EctoShorts.filter(User, %{name: %{ilike: "steve"}})
  EctoShorts.filter(User, %{name: %{age: %{gte: 18, lte: 30}}})
  EctoShorts.filter(User, %{name: %{is_banned: %{!=: nil}}})
  EctoShorts.filter(User, %{name: %{is_banned: %{==: nil}}})

  my_query = EctoShorts.filter(User, %{name: "Billy"})
  EctoShorts.filter(my_query, %{last_name: "Joe"})
  ```
  """

  def filter(module_or_query, filters, order_by_prop \\ :id, order_direction \\ :desc) do
    EctoShorts.CommonFilters.query_params(module_or_query, filters, order_by_prop, order_direction)
  end

end
