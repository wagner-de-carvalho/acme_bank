defmodule AcmeBankWeb.Router do
  use AcmeBankWeb, :router
  alias AcmeBankWeb.Plugs.Auth

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug Auth
  end

  scope "/api", AcmeBankWeb do
    pipe_through :api

    get "/", WelcomeController, :index

    post "/users", UsersController, :create
    post "/users/login", UsersController, :login
  end

  scope "/api", AcmeBankWeb do
    pipe_through [:api, :auth]

    resources "/users", UsersController, only: [:delete, :show, :update]

    post "/accounts", AccountsController, :create
    post "/accounts/transaction", AccountsController, :transaction
  end

  # Enable LiveDashboard in development
  if Application.compile_env(:acme_bank, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: AcmeBankWeb.Telemetry
    end
  end
end
