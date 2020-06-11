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

  forward "/users/:discord_id/coupon",
    to: He4rt.Routes.UserCouponsRouter

  forward "/bans",
    to: He4rt.Routes.BansRouter

  forward "/languages",
    to: He4rt.Routes.LanguagesRouter

  forward "/users",
    to: He4rt.Routes.UsersRouter

  forward "/ranking",
    to: He4rt.Routes.RankingRouter

  forward "/store",
    to: He4rt.Routes.StoreRouter

  forward "/tips/english/",
    to: He4rt.Routes.EnglishTipsRouter

  forward "/tips/development/",
    to: He4rt.Routes.DevelopmentTipsRouter

  forward "/health",
    to: He4rt.Routes.HealthRouter

  match _ do
    conn
    |> route_not_found()
  end
end
