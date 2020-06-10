defmodule He4rt.Test.Controllers.BansController do
  use ExUnit.Case, async: false
  use He4rt.Support.ConnCase,
    endpoint: He4rt.Endpoint

  alias He4rt.Support.Fixtures.Bans

  @moduletag :bans

  describe "Received request so" do
    @tag :list_bans_error_without_authentication
    test "without api key, shouldn't retrieve all bans and produce status 401 with message error [GET /bans]", %{} do
      response =
        get("/bans")
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(401)

      assert(
        not is_nil(response)
        and response["errors"]["detail"] === "Unauthorized"
      )
    end

    @tag :list_bans_error_invalid_api_key
    test "with invalid api key, shouldn't retrieve all bans and produce status 401 with message error [GET /bans]", %{} do
      response =
        get("/bans")
        |> put_req_header("api-key", "foobar")
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(401)

      assert(
        not is_nil(response)
        and response["errors"]["detail"] === "Unauthorized"
      )
    end

    @tag :list_bans_ok
    test "with valid api key, should retrieve all bans and produce status 200 without error [GET /bans]", %{} do
      Bans.insert()

      response =
        get("/bans")
        |> put_req_header("api-key", get_api_key())
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(200)

      assert(
        not is_nil(response)
        and is_list(response)
        and length(response) > 0 
      )
    end

    @tag :create_ban_error_without_authentication
    test "without api key, shouldn't create new ban and produce status 401 with message error [GET /bans]", %{} do
      response =
        post("/bans")
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(401)

      assert(
        not is_nil(response)
        and response["errors"]["detail"] === "Unauthorized"
      )
    end

    @tag :create_ban_error_invalid_api_key
    test "with invalid api key, shouldn't create new ban and produce status 401 with message error [POST /bans]", %{} do
      response =
        post("/bans")
        |> put_req_header("api-key", "foobar")
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(401)

      assert(
        not is_nil(response)
        and response["errors"]["detail"] === "Unauthorized"
      )
    end

    @tag :create_ban_ok
    test "with valid api key, should create new ban and produce status 201 without error [POST /bans]", %{} do
      params = Bans.params()

      response =
        post("/bans", params)
        |> put_req_header("api-key", get_api_key())
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(201)

      assert(
        not is_nil(response)
        and is_map(response)
        and response["id"] |> is_integer() 
        and not response["revoked"]
      )
    end

    @tag :revoke_ban_error_without_authentication
    test "without api key, shouldn't revoke ban and produce status 401 with message error [PUT /bans/:ban_id/revoke]", %{} do
      response =
        put("/bans/#{Ecto.UUID.generate() |> :erlang.phash2()}/revoke")
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(401)

      assert(
        not is_nil(response)
        and response["errors"]["detail"] === "Unauthorized"
      )
    end

    @tag :revoke_ban_error_invalid_api_key
    test "with invalid api key, shouldn't revoke ban and produce status 401 with message error [PUT /bans/:ban_id/revoke]", %{} do
      response =
        put("/bans/#{Ecto.UUID.generate() |> :erlang.phash2()}/revoke")
        |> put_req_header("api-key", "foobar")
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(401)

      assert(
        not is_nil(response)
        and response["errors"]["detail"] === "Unauthorized"
      )
    end

    @tag :revoke_ban_ok
    test "with valid api key, should revoke ban and produce status 200 without error [PUT /bans/:ban_id/revoke]", %{} do
      params = Bans.params()
      %{id: ban_id} = Bans.insert()

      response =
        put("/bans/#{ban_id}/revoke", params)
        |> put_req_header("api-key", get_api_key())
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(200)

      assert(
        not is_nil(response)
        and is_map(response)
        and response["id"] |> is_integer() 
        and response["id"] === ban_id
        and response["revoked"]
      )
    end
  end
end
