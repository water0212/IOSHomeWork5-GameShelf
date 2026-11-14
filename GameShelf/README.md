# GameShelf v2 — 11 款遊戲、玩家資料空白、可持久儲存

## 重要：你要的「沒有預設值」
- 一開始有 11 款遊戲的官方資料（名稱、類型、介紹、發行年）。
- 個人資料 **全部空白**：`rating=0`（尚未評分）、`playHours=nil`、`status=nil`、`isFavorite=false`。
- 點選遊戲進入詳細頁後，可修改評分、收藏、遊玩狀態、遊玩時數。
- `GameStore` 以 UserDefaults（gameshelf.playerData.v2）儲存更動，重啟仍保留。
- 不讀取 v1 舊資料，避免原範例評分與收藏混入；若要重設，在統計頁按「清除玩家紀錄」。

## 封面圖片安裝（Mac 連網下載）
**重要：此壓縮包內沒有已下載的官方封面圖檔。** 執行 `Artwork/download_covers.command` 後會自動下載、建立 11 個 `Assets.xcassets/*.imageset`，再將它們加入 Xcode。封面若下載失敗會保留原本的漸層＋符號作為備用。

1. 解壓縮後，在 Finder 對 `Artwork/download_covers.command` 按右鍵，選「打開」，或於終端機執行 `bash Artwork/download_covers.command`。
2. 執行完會建立 `Assets.xcassets`，將裡面的 `.imageset` 全部拖入你既有專案的 `Assets.xcassets`。
3. 將 ZIP 的 `Models/`、`Data/`、`Components/`、`Views/` 和 `ContentView.swift` 取代 Xcode 裡的舊版本；避免同名 Swift 檔重複加入 Target。
4. 只需要 iOS/iPadOS Target（iOS 18+），推薦使用 iPhone Simulator 編譯。
5. 若原 App 使用舊版遊戲資料，新版會從全新、未填寫的 11 款目錄起步；之後的玩家紀錄會保存。

## 注意
下載圖片需要 Mac 可連網，且 Steam CDN 或轉載網站可連線；網域和 CDN 路徑未來可能調整。如果某張失敗請從來源頁手動另存圖片並以對應名稱放入 Assets：HollowKnight, StardewValley, Hades, SlayTheSpire, Terraria, DeadCells, Minecraft, Portal, CounterStrike2, EldenRing, Inscryption。

圖像版權歸各遊戲的權利人；本範例僅適合作業展示。這份 ZIP **不是 .xcodeproj**，需要加進既有 Xcode 專案。本環境無法執行 Xcode 編譯。
