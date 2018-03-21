defmodule PhoenixLibcluster do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    setup_cluster_mode()

    # Define workers and child supervisors to be supervised
    children = [
      # Start the Ecto repository
      #supervisor(PhoenixLibcluster.Repo, []),
      # Start the endpoint when the application starts
      supervisor(PhoenixLibcluster.Endpoint, []),
      # Start your own worker by calling: PhoenixLibcluster.Worker.start_link(arg1, arg2, arg3)
      # worker(PhoenixLibcluster.Worker, [arg1, arg2, arg3]),
      worker(HelloCluster, [:status_message]),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PhoenixLibcluster.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    PhoenixLibcluster.Endpoint.config_change(changed, removed)
    :ok
  end

  # Set the cookie here instead of on the command line so it's not shown in the process list.
  defp setup_cluster_mode do
    require Logger

    Logger.info("Node alive=#{Node.alive?}")
    Logger.info("Environment is #{Mix.env}")
    Logger.info("Node List #{Node.list}")

    with true <- Node.alive?,
         { :ok, cookie } <- File.read(".nomnom")
    do
      cookie
      |> String.to_atom
      |> Node.set_cookie

      Logger.info("COOKIE #{Node.get_cookie}")
      Application.ensure_all_started(:libcluster)
    else
      false ->
        Logger.error("Application started without a name, cannot start cluster.")

      { :error, _ } = error ->
        Logger.error("Cookie file isn't present, cannot start cluster: #{inspect error}")
    end
  end
end
