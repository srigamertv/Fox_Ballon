# 🎈 Sistema de Balão - RedM (VORP Framework)

Este recurso permite que jogadores comprem e controlem balões de ar quente em locais definidos no mapa. O sistema é totalmente compatível com o VORP Framework e oferece integração com inventário, prompts de controle, e configurações de impostos.
>>>>>>> 5533413c9c78063581ac09ece1e37f12d81a7478

---

## 📁 Arquivos

- `config.lua` - Configuração geral do sistema.
- `server.lua` - Lógica do servidor (verificação de dinheiro, spawn do balão).
- `client.lua` - Lógica do cliente (movimentação e controle do balão).
- `utils.lua` - Sistema de prompts e interação com o NPC.

---

## ⚙️ Configurações

```lua
Config.Lang = 'Portuguese_BR'

💸 Economia

Config.EnableTax = true       -- Ativa ou desativa imposto na compra
Config.BallonPrice = 10.00    -- Preço base do balão (imposto incluso se ativado)

⌨️ Tecla de interação

Config.KeyToBuyBalloon = 0xD9D0E1C0 -- Tecla para comprar (por padrão: G)

🛒 Locais de compra
Você pode adicionar múltiplos locais:

Config.BalloonLocations = {
  [1] = {
      blip = -1595467349,
      npcmodel = "re_pisspot_males_01",
      coords = vector3(...),
      heading = ...,
      radius = 3.0,
      distancia = 20.0,
      Spawnballon = vector3(...),
  },
}

🎁 Itens que podem gerar balões

Config.Itens = {
  {
    Name = 'balon',  -- Nome do item
    Quant = 0        -- Quantidade removida (0 não remove)
  }
}
```
🧠 Como Funciona
- Jogador se aproxima do NPC do balão.
- Pressiona a tecla G para comprar um balão.

🧩 Dependências
- vorp_core
- vorp_inventory

✅ Recursos Suportados
- Uso de item para spawnar balão
- Compra com dinheiro e taxa
- Totalmente configurável
- Controle completo da movimentação

## ✍️ Créditos

Desenvolvido por SR.IGAMER | FOX  
Baseado no sistema VORP do RedM.

 <br>
 
- **Video Preview:**

| [![Assista ao vídeo](https://img.youtube.com/vi/juYjShOphmI/0.jpg)](https://www.youtube.com/watch?v=juYjShOphmI) |
| --- |

<br>

**MINHA LOJA:**
<div> 
   <a href="https://discord.gg/ySk8WVzY5n" target="_blank"><img src="https://img.shields.io/badge/Discord-7289DA?style=for-the-badge&logo=discord&logoColor=white" target="_blank"></a>
</div>

 <br>

**Siga-nos:**
<div> 
  <a href="https://www.youtube.com/@SRIGAMERTV" target="_blank"><img src="https://img.shields.io/badge/YouTube-FF0000?style=for-the-badge&logo=youtube&logoColor=white" target="_blank"></a>
  <a href="https://www.instagram.com/sr.igamer_tv" target="_blank"><img src="https://img.shields.io/badge/-Instagram-%23E4405F?style=for-the-badge&logo=instagram&logoColor=white" target="_blank"></a>
   <a href="https://discord.gg/kh2KTGvaVX" target="_blank"><img src="https://img.shields.io/badge/Discord-7289DA?style=for-the-badge&logo=discord&logoColor=white" target="_blank"></a>
</div>

 <br>

Sinta-se à vontade para modificar ou expandir esse sistema para atender às necessidades do seu servidor.
