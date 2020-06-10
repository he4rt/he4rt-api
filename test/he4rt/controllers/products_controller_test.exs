defmodule He4rt.Test.Controllers.ProductsController do
  use ExUnit.Case, async: false
  use He4rt.Support.ConnCase,
    endpoint: He4rt.Endpoint

  alias He4rt.Support.Fixtures.Products

  @moduletag :products

  describe "Received request so" do
    @tag :list_products_error_without_authentication
    test "without api key, shouldn't retrieve all products and produce status 401 with message error [GET /products]", %{} do
      response =
        get("/products")
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(401)

      assert(
        not is_nil(response)
        and response["errors"]["detail"] === "Unauthorized"
      )
    end

    @tag :list_products_error_invalid_api_key
    test "with invalid api key, shouldn't retrieve all products and produce status 401 with message error [GET /products]", %{} do
      response =
        get("/products")
        |> put_req_header("api-key", "foobar")
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(401)

      assert(
        not is_nil(response)
        and response["errors"]["detail"] === "Unauthorized"
      )
    end

    @tag :list_products_ok
    test "with valid api key, should retrieve all products and produce status 200 without error [GET /products]", %{} do
      Products.insert()

      response =
        get("/products")
        |> put_req_header("api-key", get_api_key())
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(200)

      assert(
        not is_nil(response)
        and is_list(response)
        and length(response) > 0 
      )
    end

    @tag :show_product_error_without_authentication
    test "without api key, shouldn't retrieve one product and produce status 401 with message error [GET /products]", %{} do
      response =
        get("/products")
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(401)

      assert(
        not is_nil(response)
        and response["errors"]["detail"] === "Unauthorized"
      )
    end

    @tag :show_product_error_invalid_api_key
    test "with invalid api key, shouldn't retrieve one product and produce status 401 with message error [GET /products/:product_id]", %{} do
      response =
        get("/products")
        |> put_req_header("api-key", "foobar")
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(401)

      assert(
        not is_nil(response)
        and response["errors"]["detail"] === "Unauthorized"
      )
    end

    @tag :show_product_ok
    test "with valid api key, should retrieve one product and produce status 200 without error [GET /products/:product_id]", %{} do
      %{id: product_id} = Products.insert()

      response =
        get("/products/#{product_id}")
        |> put_req_header("api-key", get_api_key())
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(200)

      assert(
        not is_nil(response)
        and is_map(response)
        and response["id"] === product_id 
      )
    end

    @tag :create_product_error_without_authentication
    test "without api key, shouldn't create new product and produce status 401 with message error [GET /products]", %{} do
      response =
        post("/products")
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(401)

      assert(
        not is_nil(response)
        and response["errors"]["detail"] === "Unauthorized"
      )
    end

    @tag :create_product_error_invalid_api_key
    test "with invalid api key, shouldn't create new product and produce status 401 with message error [POST /products]", %{} do
      response =
        post("/products")
        |> put_req_header("api-key", "foobar")
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(401)

      assert(
        not is_nil(response)
        and response["errors"]["detail"] === "Unauthorized"
      )
    end

    @tag :create_product_without_category_id_ok
    test "with valid api key and empty category id, should create new product and produce status 201 without error [POST /products]", %{} do
      params = Products.params()

      response =
        post("/products", params)
        |> put_req_header("api-key", get_api_key())
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(201)

      assert(
        not is_nil(response)
        and is_map(response)
        and response["id"] |> is_integer() 
        and response["category"] |> is_nil()
      )
    end

    @tag :create_product_ok
    test "with valid api key, should create new product and produce status 201 without error [POST /products]", %{} do
      params = Products.params(:category)

      response =
        post("/products", params)
        |> put_req_header("api-key", get_api_key())
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(201)

      assert(
        not is_nil(response)
        and is_map(response)
        and response["id"] |> is_integer() 
        and response["category"]["id"] |> is_integer()
        and response["category"]["id"] === params.category_id 
      )
    end

    @tag :update_product_error_without_authentication
    test "without api key, shouldn't update product and produce status 401 with message error [PUT /products/:product_id]", %{} do
      response =
        put("/products")
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(401)

      assert(
        not is_nil(response)
        and response["errors"]["detail"] === "Unauthorized"
      )
    end

    @tag :update_product_error_invalid_api_key
    test "with invalid api key, shouldn't update product and produce status 401 with message error [PUT /products/:product_id]", %{} do
      response =
        put("/products")
        |> put_req_header("api-key", "foobar")
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(401)

      assert(
        not is_nil(response)
        and response["errors"]["detail"] === "Unauthorized"
      )
    end

    @tag :update_product_without_category_ok
    test "with valid api key and without category id, should update product and produce status 200 without error [PUT /products/:product_id]", %{} do
      params = Products.params()
      %{id: product_id} = Products.insert()

      response =
        put("/products/#{product_id}", params)
        |> put_req_header("api-key", get_api_key())
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(200)

      assert(
        not is_nil(response)
        and is_map(response)
        and response["id"] |> is_integer() 
        and response["id"] === product_id
        and response["name"] === params.name
        and response["category"] |> is_nil()
      )
    end

    @tag :update_product_ok
    test "with valid api key, should update product and produce status 200 without error [PUT /products/:product_id]", %{} do
      params = Products.params(:category)
      %{id: product_id} = Products.insert()

      response =
        put("/products/#{product_id}", params)
        |> put_req_header("api-key", get_api_key())
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(200)

      assert(
        not is_nil(response)
        and is_map(response)
        and response["id"] |> is_integer() 
        and response["id"] === product_id
        and response["name"] === params.name
      )
    end

    @tag :remove_product_error_without_authentication
    test "without api key, shouldn't remove product and produce status 401 with message error [DELETE /products]", %{} do
      response =
        delete("/products")
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(401)

      assert(
        not is_nil(response)
        and response["errors"]["detail"] === "Unauthorized"
      )
    end

    @tag :remove_product_error_invalid_api_key
    test "with invalid api key, shouldn't remove product and produce status 401 with message error [DELETE /products/:product_id]", %{} do
      response =
        delete("/products")
        |> put_req_header("api-key", "foobar")
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(401)

      assert(
        not is_nil(response)
        and response["errors"]["detail"] === "Unauthorized"
      )
    end

    @tag :remove_product_ok
    test "with valid api key, should remove product and produce status 204 without error [DELETE /products/:product_id]", %{} do
      %{id: product_id} = Products.insert()

      delete("/products/#{product_id}")
      |> put_req_header("api-key", get_api_key())
      |> put_req_header("content-type", "application/json; charset=utf-8")
      |> json_response(204)
    end
  end
end
