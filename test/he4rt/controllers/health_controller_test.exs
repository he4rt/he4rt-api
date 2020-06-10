defmodule He4rt.Test.Controllers.HealthController do
  use ExUnit.Case, async: false
  use He4rt.Support.ConnCase,
    endpoint: He4rt.Endpoint

  @moduletag :health

  describe "Received request so" do
    test "should check if application is alive and produce status 200 without error [GET /health]", %{} do
      get("/health")
      |> put_req_header("content-type", "application/json; charset=utf-8")
      |> json_response(200)
      |> case do
        response when is_map(response) ->
          assert true

        _ ->
          assert false
      end
    end
  end
end
