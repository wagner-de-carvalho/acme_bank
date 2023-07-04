defmodule AcmeBank.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      AcmeBankWeb.Telemetry,
      # Start the Ecto repository
      AcmeBank.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: AcmeBank.PubSub},
      # Start the Endpoint (http/https)
      AcmeBankWeb.Endpoint
      # Start a worker by calling: AcmeBank.Worker.start_link(arg)
      # {AcmeBank.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: AcmeBank.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AcmeBankWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
