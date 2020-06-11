defmodule He4rt.Test.Controllers.DevelopmentTipsController do
  use ExUnit.Case, async: false
  use He4rt.Support.ConnCase,
    endpoint: He4rt.Endpoint

  alias He4rt.Support.Fixtures.DevelopmentTips

  @moduletag :development_tips

  describe "Received request so" do
    @tag :list_development_tips_error_without_authentication
    test "without api key, shouldn't retrieve all development_tips and produce status 401 with message error [GET /tips/development]", %{} do
      response =
        get("/tips/development")
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(401)

      assert(
        not is_nil(response)
        and response["errors"]["detail"] === "Unauthorized"
      )
    end

    @tag :list_development_tips_error_invalid_api_key
    test "with invalid api key, shouldn't retrieve all development_tips and produce status 401 with message error [GET /tips/development]", %{} do
      response =
        get("/tips/development")
        |> put_req_header("api-key", "foobar")
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(401)

      assert(
        not is_nil(response)
        and response["errors"]["detail"] === "Unauthorized"
      )
    end

    @tag :list_development_tips_ok
    test "with valid api key, should retrieve all development_tips and produce status 200 without error [GET /tips/development]", %{} do
      DevelopmentTips.insert()

      response =
        get("/tips/development")
        |> put_req_header("api-key", get_api_key())
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(200)

      assert(
        not is_nil(response)
        and is_list(response)
        and length(response) > 0 
      )
    end

    @tag :create_development_tip_error_without_authentication
    test "without api key, shouldn't create new development_tip and produce status 401 with message error [GET /tips/development]", %{} do
      response =
        post("/tips/development")
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(401)

      assert(
        not is_nil(response)
        and response["errors"]["detail"] === "Unauthorized"
      )
    end

    @tag :create_development_tip_error_invalid_api_key
    test "with invalid api key, shouldn't create new development_tip and produce status 401 with message error [POST /tips/development]", %{} do
      response =
        post("/tips/development")
        |> put_req_header("api-key", "foobar")
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(401)

      assert(
        not is_nil(response)
        and response["errors"]["detail"] === "Unauthorized"
      )
    end

    @tag :create_development_tip_without_language_id_ok
    test "with valid api key and empty language id, should create new development_tip and produce status 201 without error [POST /tips/development]", %{} do
      params = DevelopmentTips.params(:language)

      response =
        post("/tips/development", params)
        |> put_req_header("api-key", get_api_key())
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(201)

      assert(
        not is_nil(response)
        and is_map(response)
        and response["id"] |> is_integer() 
        and response["language"] |> is_nil()
      )
    end

    @tag :create_development_tip_ok
    test "with valid api key, should create new development_tip and produce status 201 without error [POST /tips/development]", %{} do
      params = DevelopmentTips.params()

      response =
        post("/tips/development", params)
        |> put_req_header("api-key", get_api_key())
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(201)

      assert(
        not is_nil(response)
        and is_map(response)
        and response["id"] |> is_integer() 
        and response["language"]["id"] |> is_integer()
        and response["language"]["id"] === params.language_id 
      )
    end

    @tag :remove_development_tip_error_without_authentication
    test "without api key, shouldn't remove development_tip and produce status 401 with message error [DELETE /tips/development]", %{} do
      response =
        delete("/tips/development")
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(401)

      assert(
        not is_nil(response)
        and response["errors"]["detail"] === "Unauthorized"
      )
    end

    @tag :remove_development_tip_error_invalid_api_key
    test "with invalid api key, shouldn't remove development_tip and produce status 401 with message error [DELETE /tips/development/:development_tip_id]", %{} do
      response =
        delete("/tips/development")
        |> put_req_header("api-key", "foobar")
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(401)

      assert(
        not is_nil(response)
        and response["errors"]["detail"] === "Unauthorized"
      )
    end

    @tag :remove_development_tip_ok
    test "with valid api key, should remove development_tip and produce status 204 without error [DELETE /tips/development/:development_tip_id]", %{} do
      %{id: development_tip_id} = DevelopmentTips.insert()

      delete("/tips/development/#{development_tip_id}")
      |> put_req_header("api-key", get_api_key())
      |> put_req_header("content-type", "application/json; charset=utf-8")
      |> json_response(204)
    end
  end
end
