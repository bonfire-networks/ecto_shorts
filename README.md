# EctoShorts

Helpers to make writing ecto queries more pleasant and the code shorter

### Usage

You can create queries from filter parameters, for example: 

```elixir
EctoShorts.filter(User, %{id: 5})
```
is the same as:
```elixir
from u in User, where: id == 5
```

This allows for filters to be constructed from data such as:
```elixir
EctoShorts.filter(User, %{
  favorite_food: "curry",
  age: %{gte: 18, lte: 50},
  name: %{ilike: "steven"},
  preload: [:address],
  last: 5
})
```
which would be equivalent to:
```elixir
from u in User,
  preload: [:address],
  limit: 5,
  where: u.favorite_food == "curry" and
         u.age >= 18 and u.age <= 50 and
         ilike(u.name, "%steven%")
```

You are also able to filter on any natural field of a schema, as well as use:
- gte/gt
- lte/lt
- like/ilike
- is_nil/not(is_nil)

For example:
```elixir
EctoShorts.filter(User, %{name: %{ilike: "steve"}})
EctoShorts.filter(User, %{name: "Steven", %{age: %{gte: 18, lte: 30}}})
EctoShorts.filter(User, %{is_banned: %{!=: nil}})
EctoShorts.filter(User, %{is_banned: %{==: nil}})

my_query = EctoShorts.filter(User, %{first_name: "Daft"})
EctoShorts.filter(my_query, %{last_name: "Punk"})
```

###### List of common filters
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


## License 

MIT

- Copyright 2020 Mika Kalathil
- Copyright 2021 Bonfire contributors
