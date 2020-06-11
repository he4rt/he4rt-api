defmodule He4rt.Test.Controllers.RankingController do
  use ExUnit.Case, async: false
  use He4rt.Support.ConnCase,
    endpoint: He4rt.Endpoint

  alias He4rt.Support.Fixtures.Ranking

  @moduletag :ranking

  describe "Received request so" do
    @tag :list_ranking_error_without_authentication
    test "without api key, shouldn't retrieve all ranking and produce status 401 with message error [GET /ranking]", %{} do
      response =
        get("/ranking")
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(401)

      assert(
        not is_nil(response)
        and response["errors"]["detail"] === "Unauthorized"
      )
    end

    @tag :list_ranking_error_invalid_api_key
    test "with invalid api key, shouldn't retrieve all ranking and produce status 401 with message error [GET /ranking]", %{} do
      response =
        get("/ranking")
        |> put_req_header("api-key", "foobar")
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(401)

      assert(
        not is_nil(response)
        and response["errors"]["detail"] === "Unauthorized"
      )
    end

    @tag :list_ranking_reputation_ok
    test "with valid api key, should retrieve all ranking by reputation and produce status 200 without error [GET /ranking]", %{} do
      for _i <- 1..10 do
        Ranking.insert()
      end

      response =
        get("/ranking?reputation=true")
        |> put_req_header("api-key", get_api_key())
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(200)

      assert(
        not is_nil(response)
        and is_list(response)
        and length(response) === 10 
      )
    end

    @tag :list_ranking_reputation_ok
    test "with valid api key, should retrieve all ranking by level and produce status 200 without error [GET /ranking]", %{} do
      for _i <- 1..10 do
        Ranking.insert()
      end

      response =
        get("/ranking?reputation=false")
        |> put_req_header("api-key", get_api_key())
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(200)

      assert(
        not is_nil(response)
        and is_list(response)
        and length(response) === 10 
      )
    end
  end
end
