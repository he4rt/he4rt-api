defmodule He4rt.Test.Controllers.EnglishTipsController do
  use ExUnit.Case, async: false
  use He4rt.Support.ConnCase,
    endpoint: He4rt.Endpoint

  alias He4rt.Support.Fixtures.EnglishTips

  @moduletag :english_tips

  describe "Received request so" do
    @tag :list_english_tips_error_without_authentication
    test "without api key, shouldn't retrieve all english_tips and produce status 401 with message error [GET /tips/english]", %{} do
      response =
        get("/tips/english")
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(401)

      assert(
        not is_nil(response)
        and response["errors"]["detail"] === "Unauthorized"
      )
    end

    @tag :list_english_tips_error_invalid_api_key
    test "with invalid api key, shouldn't retrieve all english_tips and produce status 401 with message error [GET /tips/english]", %{} do
      response =
        get("/tips/english")
        |> put_req_header("api-key", "foobar")
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(401)

      assert(
        not is_nil(response)
        and response["errors"]["detail"] === "Unauthorized"
      )
    end

    @tag :list_english_tips_ok
    test "with valid api key, should retrieve all english_tips and produce status 200 without error [GET /tips/english]", %{} do
      EnglishTips.insert()

      response =
        get("/tips/english")
        |> put_req_header("api-key", get_api_key())
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(200)

      assert(
        not is_nil(response)
        and is_list(response)
        and length(response) > 0 
      )
    end

    @tag :create_english_tip_error_without_authentication
    test "without api key, shouldn't create new english_tip and produce status 401 with message error [GET /tips/english]", %{} do
      response =
        post("/tips/english")
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(401)

      assert(
        not is_nil(response)
        and response["errors"]["detail"] === "Unauthorized"
      )
    end

    @tag :create_english_tip_error_invalid_api_key
    test "with invalid api key, shouldn't create new english_tip and produce status 401 with message error [POST /tips/english]", %{} do
      response =
        post("/tips/english")
        |> put_req_header("api-key", "foobar")
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(401)

      assert(
        not is_nil(response)
        and response["errors"]["detail"] === "Unauthorized"
      )
    end

    @tag :create_english_tip_ok
    test "with valid api key, should create new english_tip and produce status 201 without error [POST /tips/english]", %{} do
      params = EnglishTips.params()

      response =
        post("/tips/english", params)
        |> put_req_header("api-key", get_api_key())
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(201)

      assert(
        not is_nil(response)
        and is_map(response)
        and response["id"] |> is_integer() 
        and response["tip"] === params.tip
      )
    end

    @tag :remove_english_tip_error_without_authentication
    test "without api key, shouldn't remove english_tip and produce status 401 with message error [DELETE /tips/english]", %{} do
      response =
        delete("/tips/english")
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(401)

      assert(
        not is_nil(response)
        and response["errors"]["detail"] === "Unauthorized"
      )
    end

    @tag :remove_english_tip_error_invalid_api_key
    test "with invalid api key, shouldn't remove english_tip and produce status 401 with message error [DELETE /tips/english/:english_tip_id]", %{} do
      response =
        delete("/tips/english")
        |> put_req_header("api-key", "foobar")
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(401)

      assert(
        not is_nil(response)
        and response["errors"]["detail"] === "Unauthorized"
      )
    end

    @tag :remove_english_tip_ok
    test "with valid api key, should remove english_tip and produce status 204 without error [DELETE /tips/english/:english_tip_id]", %{} do
      %{id: english_tip_id} = EnglishTips.insert()

      delete("/tips/english/#{english_tip_id}")
      |> put_req_header("api-key", get_api_key())
      |> put_req_header("content-type", "application/json; charset=utf-8")
      |> json_response(204)
    end
  end
end
