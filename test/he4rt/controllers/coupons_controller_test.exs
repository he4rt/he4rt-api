defmodule He4rt.Test.Controllers.CouponsController do
  use ExUnit.Case, async: false
  use He4rt.Support.ConnCase,
    endpoint: He4rt.Endpoint

  alias He4rt.Support.Fixtures.{Coupons, Users}

  @moduletag :coupons

  describe "Received /coupons request so" do
    @tag :create_coupon_error_without_authentication
    test "without api key, shouldn't create new coupon and produce status 401 with message error [POST /coupons]", %{} do
      response =
        post("/coupons")
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(401)

      assert(
        not is_nil(response)
        and response["errors"]["detail"] === "Unauthorized"
      )
    end

    @tag :create_coupon_error_invalid_api_key
    test "with invalid api key, shouldn't create new coupon and produce status 401 with message error [POST /coupons]", %{} do
      response =
        post("/coupons")
        |> put_req_header("api-key", "foobar")
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(401)

      assert(
        not is_nil(response)
        and response["errors"]["detail"] === "Unauthorized"
      )
    end

    @tag :create_coupon_ok
    test "with valid api key, should create new coupon and produce status 201 without error [POST /coupons]", %{} do
      params = Coupons.params()

      response =
        post("/coupons", params)
        |> put_req_header("api-key", get_api_key())
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(201)

      assert(
        not is_nil(response)
        and is_map(response)
        and response["id"] |> is_integer() 
      )
    end
  end

  describe "Received /users request so" do
    @tag :use_coupon_error_without_authentication
    test "without api key, shouldn't use coupon and produce status 401 with message error [POST /users/:discord_id/coupon]", %{} do
      response =
        post("/users/#{999999}/coupon")
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(401)

      assert(
        not is_nil(response)
        and response["errors"]["detail"] === "Unauthorized"
      )
    end

    @tag :use_coupon_error_invalid_api_key
    test "with invalid api key, shouldn't use coupon and produce status 401 with message error [POST /users/:discord_id/coupon]", %{} do
      response =
        post("/users/#{999999}/coupon")
        |> put_req_header("api-key", "foobar")
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(401)

      assert(
        not is_nil(response)
        and response["errors"]["detail"] === "Unauthorized"
      )
    end

    @tag :create_coupon_ok
    test "with valid api key, should use coupon and produce status 201 without error [POST /users/:discord_id/coupon]", %{} do
      %{name: name} = Coupons.insert()
      %{discord_id: discord_id} = Users.insert()

      response =
        post("/users/#{discord_id}/coupon", %{coupon: name})
        |> put_req_header("api-key", get_api_key())
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(200)

      assert(
        not is_nil(response)
        and is_map(response)
        and response["id"] |> is_integer() 
        and response["name"] === name
        and response["used"] == true
        and not (response["user"] |> is_nil())
      )
    end
  end
end
