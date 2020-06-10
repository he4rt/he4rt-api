defmodule He4rt.Test.Controllers.CategoriesController do
  use ExUnit.Case, async: false
  use He4rt.Support.ConnCase,
    endpoint: He4rt.Endpoint

  alias He4rt.Support.Fixtures.Categories

  @moduletag :categories

  describe "Received request so" do
    @tag :list_categories_error_without_authentication
    test "without api key, shouldn't retrieve all categories and produce status 401 with message error [GET /categories]", %{} do
      response =
        get("/categories")
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(401)

      assert(
        not is_nil(response)
        and response["errors"]["detail"] === "Unauthorized"
      )
    end

    @tag :list_categories_error_invalid_api_key
    test "with invalid api key, shouldn't retrieve all categories and produce status 401 with message error [GET /categories]", %{} do
      response =
        get("/categories")
        |> put_req_header("api-key", "foobar")
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(401)

      assert(
        not is_nil(response)
        and response["errors"]["detail"] === "Unauthorized"
      )
    end

    @tag :list_categories_ok
    test "with valid api key, should retrieve all categories and produce status 200 without error [GET /categories]", %{} do
      Categories.insert()

      response =
        get("/categories")
        |> put_req_header("api-key", get_api_key())
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(200)

      assert(
        not is_nil(response)
        and is_list(response)
        and length(response) > 0 
      )
    end

    @tag :show_category_error_without_authentication
    test "without api key, shouldn't retrieve one category and produce status 401 with message error [GET /categories]", %{} do
      response =
        get("/categories")
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(401)

      assert(
        not is_nil(response)
        and response["errors"]["detail"] === "Unauthorized"
      )
    end

    @tag :show_category_error_invalid_api_key
    test "with invalid api key, shouldn't retrieve one category and produce status 401 with message error [GET /categories/:category_id]", %{} do
      response =
        get("/categories")
        |> put_req_header("api-key", "foobar")
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(401)

      assert(
        not is_nil(response)
        and response["errors"]["detail"] === "Unauthorized"
      )
    end

    @tag :show_category_ok
    test "with valid api key, should retrieve one category and produce status 200 without error [GET /categories/:category_id]", %{} do
      %{id: category_id} = Categories.insert()

      response =
        get("/categories/#{category_id}")
        |> put_req_header("api-key", get_api_key())
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(200)

      assert(
        not is_nil(response)
        and is_map(response)
        and response["id"] === category_id 
      )
    end

    @tag :create_category_error_without_authentication
    test "without api key, shouldn't create new category and produce status 401 with message error [GET /categories]", %{} do
      response =
        post("/categories")
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(401)

      assert(
        not is_nil(response)
        and response["errors"]["detail"] === "Unauthorized"
      )
    end

    @tag :create_category_error_invalid_api_key
    test "with invalid api key, shouldn't create new category and produce status 401 with message error [POST /categories]", %{} do
      response =
        post("/categories")
        |> put_req_header("api-key", "foobar")
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(401)

      assert(
        not is_nil(response)
        and response["errors"]["detail"] === "Unauthorized"
      )
    end

    @tag :create_category_ok
    test "with valid api key, should create new category and produce status 201 without error [POST /categories]", %{} do
      params = Categories.params()

      response =
        post("/categories", params)
        |> put_req_header("api-key", get_api_key())
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(201)

      assert(
        not is_nil(response)
        and is_map(response)
        and response["id"] |> is_integer() 
      )
    end

    @tag :update_category_error_without_authentication
    test "without api key, shouldn't update category and produce status 401 with message error [PUT /categories/:category_id]", %{} do
      response =
        put("/categories")
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(401)

      assert(
        not is_nil(response)
        and response["errors"]["detail"] === "Unauthorized"
      )
    end

    @tag :update_category_error_invalid_api_key
    test "with invalid api key, shouldn't update category and produce status 401 with message error [PUT /categories/:category_id]", %{} do
      response =
        put("/categories")
        |> put_req_header("api-key", "foobar")
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(401)

      assert(
        not is_nil(response)
        and response["errors"]["detail"] === "Unauthorized"
      )
    end

    @tag :update_category_ok
    test "with valid api key, should update category and produce status 200 without error [PUT /categories/:category_id]", %{} do
      params = Categories.params()
      %{id: category_id} = Categories.insert()

      response =
        put("/categories/#{category_id}", params)
        |> put_req_header("api-key", get_api_key())
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(200)

      assert(
        not is_nil(response)
        and is_map(response)
        and response["id"] |> is_integer() 
        and response["id"] === category_id
        and response["name"] === params.name
      )
    end

    @tag :remove_category_error_without_authentication
    test "without api key, shouldn't remove category and produce status 401 with message error [DELETE /categories]", %{} do
      response =
        delete("/categories")
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(401)

      assert(
        not is_nil(response)
        and response["errors"]["detail"] === "Unauthorized"
      )
    end

    @tag :remove_category_error_invalid_api_key
    test "with invalid api key, shouldn't remove category and produce status 401 with message error [DELETE /categories/:category_id]", %{} do
      response =
        delete("/categories")
        |> put_req_header("api-key", "foobar")
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(401)

      assert(
        not is_nil(response)
        and response["errors"]["detail"] === "Unauthorized"
      )
    end

    @tag :remove_category_ok
    test "with valid api key, should remove category and produce status 204 without error [DELETE /categories/:category_id]", %{} do
      %{id: category_id} = Categories.insert()

      delete("/categories/#{category_id}")
      |> put_req_header("api-key", get_api_key())
      |> put_req_header("content-type", "application/json; charset=utf-8")
      |> json_response(204)
    end
  end
end
