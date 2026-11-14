import SwiftUI
import Combine

/// 單一資料來源。只儲存玩家對遊戲的修改，目錄隨新版 App 一起更新。
@MainActor
final class GameStore: ObservableObject {
    // v2 不讀取舊版示範評分/時數，避免把不屬於玩家的資料帶進來
    private static let storageKey = "gameshelf.playerData.v2"

    @Published var games: [Game] {
        didSet { save() }
    }

    init() {
        // 只從新目錄產生遊戲清單，按穩定 ID 合併玩家存檔
        let catalog = SampleGames.all
        if let data = UserDefaults.standard.data(forKey: Self.storageKey),
           let saved = try? JSONDecoder().decode([Game].self, from: data) {
            let byID = Dictionary(uniqueKeysWithValues: saved.map { ($0.id, $0) })
            games = catalog.map { item in
                var game = item
                if let old = byID[item.id] {
                    game.rating = old.rating
                    game.playHours = old.playHours
                    game.status = old.status
                    game.isFavorite = old.isFavorite
                }
                return game
            }
        } else {
            games = catalog
        }
    }

    func resetToSamples() {
        games = SampleGames.all
    }

    private func save() {
        guard let data = try? JSONEncoder().encode(games) else { return }
        UserDefaults.standard.set(data, forKey: Self.storageKey)
    }
}
