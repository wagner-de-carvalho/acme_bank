defmodule AcmeBank.ViaCep.ClientTest do
  use ExUnit.Case, async: true
  alias AcmeBank.ViaCep.Client

  setup do
    bypass = Bypass.open()
    {:ok, bypass: bypass}
  end

  describe "call/1" do
    test "Successfully returns a cep info", %{bypass: bypass} do
      cep = "29560000"

      body = ~s({
      "bairro": "",
      "cep": "29460000",
      "complemento": "",
      "ddd": "28",
      "gia": "",
      "ibge": "3201100",
      "localidade": "Bom Jesus do Norte",
      "logradouro": "",
      "siafi": "5621",
      "uf": "ES"
    })

      expected_response =
        {:ok,
         %{
           "bairro" => "",
           "cep" => "29460000",
           "complemento" => "",
           "ddd" => "28",
           "gia" => "",
           "ibge" => "3201100",
           "localidade" => "Bom Jesus do Norte",
           "logradouro" => "",
           "siafi" => "5621",
           "uf" => "ES"
         }}

      Bypass.expect(bypass, fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, body)
      end)

      response =
        bypass.port
        |> endpoint_url()
        |> Client.call(cep)

      assert response == expected_response
    end
  end

  defp endpoint_url(port), do: "http://localhost:#{port}"
end
