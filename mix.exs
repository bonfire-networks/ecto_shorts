defmodule EctoShorts.MixProject do
  use Mix.Project

  def project do
    [
      app: :ecto_shorts,
      version: "0.1.8-bonfire.1",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: "Helpers to make writing ecto queries more pleasant and the code shorter",
      docs: docs(),
      package: package()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto_sql, "~> 3.3"},
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:ecto_sparkles, "https://github.com/bonfire-networks/ecto_sparkles", optional: true}
    ]
  end

  defp package do
    [
      maintainers: ["Bonfire", "Mika Kalathil"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/MikaAK/ecto_shorts"},
      files: ~w(mix.exs README.md CHANGELOG.md lib)
    ]
  end

  defp docs do
    [
      main: "EctoShorts",
      source_url: "https://github.com/MikaAK/ecto_shorts",
      groups_for_modules: [
        "Main Modules": [
          EctoShorts.Actions,
          EctoShorts.CommonChanges
        ],

        "Support Modules": [
          EctoShorts.CommonFilters,
          EctoShorts.SchemaHelpers
        ],

        "Misc Modules": [
          EctoShorts.Actions.Error,
          EctoShorts.Repo
        ],

        "Query Builder Modules": [
          EctoShorts.QueryBuilder,
          EctoShorts.QueryBuilder.Schema,
          EctoShorts.QueryBuilder.Common
        ]
      ]
    ]
  end
end
