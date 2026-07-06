defmodule EctoShorts.Config do
  @app :ecto_shorts

  # test/dev keep the ProcessTree repo swap (multi-instance test repos); in prod a ProcessTree
  # MISS would walk the whole process ancestry on every EctoShorts call
  if Mix.env() in [:test, :dev] do
    def repo do
      ProcessTree.get(:ecto_repo_module) || Application.get_env(@app, :repo)
    end
  else
    def repo do
      Application.get_env(@app, :repo)
    end
  end
end
