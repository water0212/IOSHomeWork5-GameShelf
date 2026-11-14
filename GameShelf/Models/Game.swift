import SwiftUI

enum GameStatus: String, CaseIterable, Identifiable, Codable {
    case wishlist = "想玩"
    case playing = "遊玩中"
    case completed = "已通關"

    var id: String { rawValue }
    var systemImage: String {
        switch self {
        case .wishlist: "bookmark"
        case .playing: "play.circle"
        case .completed: "checkmark.seal.fill"
        }
    }
}

enum GameAccent: String, Codable {
    case indigo, teal, orange, rose, green, purple, blue, amber, mint, red

    var color: Color {
        switch self {
        case .indigo: .indigo
        case .teal: .teal
        case .orange: .orange
        case .rose: .pink
        case .green: .green
        case .purple: .purple
        case .blue: .blue
        case .amber: .yellow
        case .mint: .mint
        case .red: .red
        }
    }
}

struct Game: Identifiable, Codable {
    // 穩定 ID：之後重整清單或新增遊戲不會破壞玩家記錄
    let id: String
    let title: String
    let genre: String
    let releaseYear: Int
    let description: String
    let coverName: String
    let coverSymbol: String
    let accent: GameAccent

    // 玩家資料：完全不預填；收藏從未選取開始
    var rating: Int = 0              // 0 = 尚未評分
    var playHours: Int? = nil         // nil = 尚未填寫
    var status: GameStatus? = nil     // nil = 尚未設定狀態
    var isFavorite: Bool = false
}
