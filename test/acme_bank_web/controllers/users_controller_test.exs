defmodule AcmeBankWeb.UsersControllerTest do
  use AcmeBankWeb.ConnCase, async: true
  import Mox
  alias AcmeBank.Users
  alias AcmeBank.ViaCep.ClientMock

  setup do
    # Mox
    :verify_on_exit!

    user_params = %{"name" => "Acme Test", "email" => "acmetest@mail.com", "password" => "123456", "cep" => "29560000"}
    user_invalid_params = %{"name" => "Acme Test", "email" => "acmetest", "password" => "123456", "cep" => "1234567"}

    body = %{
      "bairro" => "",
      "cep" => "29460-000",
      "complemento" => "",
      "ddd" => "28",
      "gia" => "",
      "ibge" => "3201100",
      "localidade" => "Bom Jesus do Norte",
      "logradouro" => "",
      "siafi" => "5621",
      "uf" => "ES"
    }

    %{user_params: user_params, user_invalid_params: user_invalid_params, body: body}
  end

  describe "create/2" do
    test "creates an user successfully", %{conn: conn, user_params: params, body: body} do
      expect(ClientMock, :call, fn _cep -> {:ok, body} end)

      response =
        conn
        |> post(~p"/api/users", params)
        |> json_response(:created)

      assert response == %{
               "data" => %{"cep" => "29560000", "email" => "acmetest@mail.com", "name" => "Acme Test"},
               "message" => "User created"
             }
    end

    test "returns an error when there are invalid params", %{conn: conn, user_invalid_params: params} do
      expect(ClientMock, :call, fn _cep -> {:error, :bad_request} end)

      response =
        conn
        |> post(~p"/api/users", params)
        |> json_response(:bad_request)

      assert response == %{"status" => "bad_request"}
    end
  end

  describe "delete/2" do
    test "successfully deletes an user", %{conn: conn, body: body, user_params: params} do
      expect(ClientMock, :call, fn _cep -> {:ok, body} end)
      {:ok, user} = Users.create(params)

      conn = conn |> delete(~p"/api/users/#{user.id}")
      assert response(conn, 204)
    end
  end
end
