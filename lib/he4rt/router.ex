defmodule He4rt.Router do
  @moduledoc false
  use Plug.Router
  import He4rt.Views.ErrorView

  plug :match
  plug :dispatch

  forward "/categories",
    to: He4rt.Routes.CategoriesRouter

  forward "/products",
    to: He4rt.Routes.ProductsRouter

  forward "/coupons",
    to: He4rt.Routes.CouponsRouter

  forward "/bans",
    to: He4rt.Routes.BansRouter

  forward "/languages",
    to: He4rt.Routes.LanguagesRouter

  forward "/health",
    to: He4rt.Routes.HealthRouter

  match _ do
    conn
    |> route_not_found()
  end
end
