Mox.defmock(AcmeBank.ViaCep.ClientMock, for: AcmeBank.ViaCep.ClientBehaviour)
Application.put_env(:acme_bank, :via_cep_client, AcmeBank.ViaCep.ClientMock)

ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(AcmeBank.Repo, :manual)
