defmodule He4rt.Test.Controllers.LanguagesController do
  use ExUnit.Case, async: false
  use He4rt.Support.ConnCase,
    endpoint: He4rt.Endpoint

  alias He4rt.Support.Fixtures.Languages

  @moduletag :languages

  describe "Received request so" do
    @tag :list_languages_error_without_authentication
    test "without api key, shouldn't retrieve all languages and produce status 401 with message error [GET /languages]", %{} do
      response =
        get("/languages")
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(401)

      assert(
        not is_nil(response)
        and response["errors"]["detail"] === "Unauthorized"
      )
    end

    @tag :list_languages_error_invalid_api_key
    test "with invalid api key, shouldn't retrieve all languages and produce status 401 with message error [GET /languages]", %{} do
      response =
        get("/languages")
        |> put_req_header("api-key", "foobar")
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(401)

      assert(
        not is_nil(response)
        and response["errors"]["detail"] === "Unauthorized"
      )
    end

    @tag :list_languages_ok
    test "with valid api key, should retrieve all languages and produce status 200 without error [GET /languages]", %{} do
      Languages.insert()

      response =
        get("/languages")
        |> put_req_header("api-key", get_api_key())
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(200)

      assert(
        not is_nil(response)
        and is_list(response)
        and length(response) > 0 
      )
    end

    @tag :show_language_error_without_authentication
    test "without api key, shouldn't retrieve one language and produce status 401 with message error [GET /languages]", %{} do
      response =
        get("/languages")
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(401)

      assert(
        not is_nil(response)
        and response["errors"]["detail"] === "Unauthorized"
      )
    end

    @tag :show_language_error_invalid_api_key
    test "with invalid api key, shouldn't retrieve one language and produce status 401 with message error [GET /languages/:language_id]", %{} do
      response =
        get("/languages")
        |> put_req_header("api-key", "foobar")
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(401)

      assert(
        not is_nil(response)
        and response["errors"]["detail"] === "Unauthorized"
      )
    end

    @tag :show_language_ok
    test "with valid api key, should retrieve one language and produce status 200 without error [GET /languages/:language_id]", %{} do
      %{id: language_id} = Languages.insert()

      response =
        get("/languages/#{language_id}")
        |> put_req_header("api-key", get_api_key())
        |> put_req_header("content-type", "application/json; charset=utf-8")
        |> json_response(200)

      assert(
        not is_nil(response)
        and is_map(response)
        and response["id"] === language_id 
      )
    end
  end
end
