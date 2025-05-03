Config = {}

-- Language settings 🌍
Config.Lang = 'Portuguese_BR'

-------------------------------------------------------------------------------------------------------------
-- [ ESPAÇO ] Tecla para iniciar a compra do balão
-------------------------------------------------------------------------------------------------------------
Config.KeyToBuyBalloon = 0xD9D0E1C0 

-------------------------------------------------------------------------------------------------------------
-- Configurações de preços e impostos 💰
-------------------------------------------------------------------------------------------------------------
Config.EnableTax = true  -- Toggle to enable/disable tax on purchases
Config.BallonPrice = 10.00 -- Base price for balloons (tax applied if EnableTax is true)

-------------------------------------------------------------------------------------------------------------
-- Locais de compra de balões 🎈
-------------------------------------------------------------------------------------------------------------
Config.BalloonLocations = {
  [1] = {
      blip = -1595467349,
      npcmodel = "re_pisspot_males_01",
      coords = vector3(-325.143, 748.1788, 117.18 ),
      heading = 336.8,
      radius = 3.0,
      distancia = 20.0,
      Spawnballon = vector3(-320.553, 753.0338, 117.09),
  },
  [2] = {
      blip = -1595467349,
      npcmodel = "re_pisspot_males_01",
      coords = vector3(-343.846, -368.755, 88.074),
      heading = 20.66,
      radius = 3.0,
      distancia = 20.0,
      Spawnballon = vector3(-350.339, -367.051, 87.263),
  },
  -- Adicione mais locais aqui
}
-------------------------------------------------------------------------------------------------------------
-- SPANAR BALÃO POR ITEM
-------------------------------------------------------------------------------------------------------------
Config.Itens ={
      {
          Name = 'balon',--nome do item
          Quant = 0, --quantidade que será consumido (0 nao consumirá o item)
      },
  }

