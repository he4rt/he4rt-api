defmodule He4rt.Test.Controllers.StoreController do
  use ExUnit.Case, async: false
  use He4rt.Support.ConnCase,
    endpoint: He4rt.Endpoint

  alias He4rt.Support.Fixtures.Store

  @moduletag :store

  describe "Received request so" do
    @tag :buy_store_error_without_authentication
    test "without api key, shouldn't retrieve buy product and produce status 401 with message error [POST /store]", %{} do
      response =
        post("/store")
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(401)

      assert(
        not is_nil(response)
        and response["errors"]["detail"] === "Unauthorized"
      )
    end

    @tag :buy_store_error_invalid_api_key
    test "with invalid api key, shouldn't buy product and produce status 401 with message error [POST /store]", %{} do
      response =
        post("/store")
        |> put_req_header("api-key", "foobar")
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(401)

      assert(
        not is_nil(response)
        and response["errors"]["detail"] === "Unauthorized"
      )
    end

    @tag :buy_store_error_not_found1
    test "with valid api key and invalid product id, shouldn't buy product and produce status 422 with message error [POST /store]", %{} do
      params = Store.params(:invalid_product_id)

      response =
        post("/store", params)
        |> put_req_header("api-key", get_api_key())
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(404)

      assert(
        not is_nil(response)
        and response["errors"]["detail"] === "Resource not found"
      )
    end

    @tag :buy_store_error_not_found2
    test "with valid api key and invalid discord id, shouldn't buy product and produce status 422 with message error [POST /store]", %{} do
      params = Store.params(:invalid_discord_id)

      response =
        post("/store", params)
        |> put_req_header("api-key", get_api_key())
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(404)

      assert(
        not is_nil(response)
        and response["errors"]["detail"] === "Resource not found"
      )
    end

    @tag :buy_store_ok
    test "with valid api key, should buy product and produce status 201 without error [POST /store]", %{} do
      params = Store.params()

      response =
        post("/store", params)
        |> put_req_header("api-key", get_api_key())
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(201)

      assert(
        not is_nil(response)
        and is_map(response)
        and response["product"]["id"] === params.product_id 
        and response["user"]["discord_id"] === params.discord_id 
      )
    end
  end
end
