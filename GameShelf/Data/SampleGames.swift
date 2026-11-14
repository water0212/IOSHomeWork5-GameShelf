import Foundation

enum SampleGames {
    // 僅預建遊戲目錄，評分/收藏/時數/狀態全部留給玩家填寫
    static let all: [Game] = [
        Game(id: "hollow-knight", title: "Hollow Knight", genre: "動作冒險", releaseYear: 2017,
             description: "探索聖巢地下王國，在充滿祕密的世界裡戰鬥與冒險。", coverName: "HollowKnight",
             coverSymbol: "moon.stars.fill", accent: .indigo),
        Game(id: "stardew-valley", title: "Stardew Valley", genre: "農場生活模擬", releaseYear: 2016,
             description: "經營農場、釣魚、採礦，與鵜鶘鎮的居民建立關係。", coverName: "StardewValley",
             coverSymbol: "leaf.fill", accent: .green),
        Game(id: "hades", title: "Hades", genre: "動作 Roguelike", releaseYear: 2020,
             description: "扮演冥界王子，不斷挑戰地獄並逐漸揭開家族故事。", coverName: "Hades",
             coverSymbol: "flame.fill", accent: .red),
        Game(id: "slay-the-spire", title: "Slay the Spire", genre: "卡牌構築 Roguelike", releaseYear: 2019,
             description: "收集卡牌與遺物，打造牌組，挑戰不斷變化的高塔。", coverName: "SlayTheSpire",
             coverSymbol: "suit.spade.fill", accent: .purple),
        Game(id: "terraria", title: "Terraria", genre: "沙盒生存冒險", releaseYear: 2011,
             description: "探索像素世界，收集資源、建造基地並擊敗強大頭目。", coverName: "Terraria",
             coverSymbol: "hammer.fill", accent: .teal),
        Game(id: "dead-cells", title: "Dead Cells", genre: "動作 Roguelite", releaseYear: 2018,
             description: "在隨機關卡裡探索城堡，以快速戰鬥與反覆挑戰突破難關。", coverName: "DeadCells",
             coverSymbol: "bolt.fill", accent: .rose),
        Game(id: "minecraft", title: "Minecraft", genre: "沙盒建造", releaseYear: 2011,
             description: "在方塊世界中探索、創造建築，體驗生存或自由創作。", coverName: "Minecraft",
             coverSymbol: "cube.fill", accent: .mint),
        Game(id: "portal", title: "Portal", genre: "第一人稱解謎", releaseYear: 2007,
             description: "使用傳送門槍解開 Aperture Science 實驗室的物理謎題。", coverName: "Portal",
             coverSymbol: "circle.hexagongrid.fill", accent: .blue),
        Game(id: "counter-strike-2", title: "Counter-Strike 2", genre: "多人戰術射擊", releaseYear: 2023,
             description: "以團隊合作、戰術與準確槍法取勝的競技射擊遊戲。", coverName: "CounterStrike2",
             coverSymbol: "scope", accent: .orange),
        Game(id: "elden-ring", title: "ELDEN RING", genre: "動作角色扮演", releaseYear: 2022,
             description: "探索交界地的廣大開放世界，挑戰強敵並追尋艾爾登之王之路。", coverName: "EldenRing",
             coverSymbol: "shield.fill", accent: .amber),
        Game(id: "inscryption", title: "INSCRYPTION", genre: "卡牌解謎與恐怖", releaseYear: 2021,
             description: "結合牌組構築、密室解謎與心理驚悚的神祕卡牌冒險。", coverName: "Inscryption",
             coverSymbol: "rectangle.on.rectangle.angled", accent: .indigo)
    ]
}
