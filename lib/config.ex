defmodule EctoShorts.Config do
  @app :ecto_shorts

  def repo do
    Process.get(:ecto_repo_module) || Application.get_env(@app, :repo)
  end
end
