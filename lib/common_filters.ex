defmodule EctoShorts.CommonFilters do
  @moduledoc """
  Calls a collection of common schema filters, which are found in:any()
  - EctoShorts.QueryBuilder.Common
  - EctoShorts.QueryBuilder.Schema
  """

  import Ecto.Query, only: [where: 2, order_by: 2]
  require Logger

  alias EctoShorts.QueryBuilder

  @common_filters QueryBuilder.Common.filters()

  @doc "Converts filter params into a query"
  @spec query_params(
    queryable :: Ecto.Query.t(),
    params :: Keyword.t | map
  ) :: Ecto.Query.t
  def query_params(query, params, order_by_prop \\ :id)

  def query_params(query, params, _) when params === %{}, do: query
  def query_params(query, params, order_by_prop) when is_map(params), do: query_params(query, Map.to_list(params), order_by_prop)


  def query_params(query, params, nil) do
    params
      |> ensure_last_is_final_filter
      |> Enum.reduce(query, &filter/2)
  end

  def query_params(query, params, order_by_prop) do
    params
      |> ensure_last_is_final_filter
      |> Enum.reduce(order_by(query, ^order_by_prop), &filter/2)
  end

  def filter({filter, _} = filter_tuple, query) when filter in @common_filters do
    QueryBuilder.filter(QueryBuilder.Common, filter_tuple, query)
  end

  def filter({filter, {filter_fn, val}}, query) when is_function(filter_fn) do
    QueryBuilder.filter(filter_fn, filter, val, query)
  end

  def filter({filter, {val, filter_fn}}, query) when is_function(filter_fn) do
    QueryBuilder.filter(filter_fn, filter, val, query)
  end

  def filter({filter, filter_fn}, query) when is_function(filter_fn) do
    QueryBuilder.filter(filter_fn, filter, query)
  end

  def filter({_filter, %Ecto.Query.DynamicExpr{} = dynamic_filter}, query) do
    query |> where(^dynamic_filter)
  end

  def filter(filter_tuple, query) do
    QueryBuilder.filter(QueryBuilder.Schema, filter_tuple, query)
  end

  defp ensure_last_is_final_filter(params) do
    if Keyword.has_key?(params, :last) do
      params
        |> Keyword.delete(:last)
        |> Kernel.++([last: params[:last]])
    else
      params
    end
  end
end
