defmodule AcmeBankWeb.UsersControllerTest do
  use AcmeBankWeb.ConnCase, async: true
  alias AcmeBank.Users

  setup do
    user_params = %{name: "Acme Test", email: "acmetest@mail.com", password: "123456", cep: "12345678"}
    user_invalid_params = %{name: "Acme Test", email: "acmetest", password: "123456", cep: "1234567"}
    %{user_params: user_params, user_invalid_params: user_invalid_params}
  end

  describe "create/2" do
    test "creates an user successfully", %{conn: conn, user_params: params} do
      response =
        conn
        |> post(~p"/api/users", params)
        |> json_response(:created)

      assert response == %{
               "data" => %{"cep" => "12345678", "email" => "acmetest@mail.com", "name" => "Acme Test"},
               "message" => "User created"
             }
    end

    test "returns an error when there are invalid params", %{conn: conn, user_invalid_params: params} do
      response =
        conn
        |> post(~p"/api/users", params)
        |> json_response(:bad_request)

      assert response == %{"errors" => %{"cep" => ["should be 8 character(s)"], "email" => ["has invalid format"]}}
    end
  end

  describe "delete/2" do
    test "successfully deletes an user", %{conn: conn, user_params: params} do
      {:ok, user} = Users.create(params)

      conn = conn |> delete(~p"/api/users/#{user.id}")
      assert response(conn, 204)
    end
  end
end
