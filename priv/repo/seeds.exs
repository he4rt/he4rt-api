alias He4rt.Modules.{CouponTypes, LevelUps, Languages}

# Types
["EXP", "COIN"]
|> Enum.each(fn name ->
  {:ok, _} = CouponTypes.create %{name: name}
end)

# Experience
[
  10, 100, 200, 300, 400, 500, 600, 700, 800, 900, 1001, 1200, 1400, 
  1600, 1800, 2000, 2200, 2400, 2600, 2800, 3001, 3300, 3600, 3900, 
  4200, 4500, 4800, 5100, 5400, 5700, 6001, 6400, 6800, 7200, 8000, 
  8400, 8800, 9200, 9600, 10000, 10501, 11000, 11500, 12000, 12500, 
  13000, 13500, 14000, 14500, 15001
]
|> Enum.each(fn exp ->
  {:ok, _} = LevelUps.create %{required_exp: exp}
end)

# Programming Languages
["Javascript", "Java", "PHP", "Ruby", "Python", "Elixir", "R"]
|> Enum.each(fn language ->
  {:ok, _} = Languages.create %{name: language}
end)
