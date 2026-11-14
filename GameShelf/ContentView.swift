import SwiftUI

struct ContentView: View {
    @StateObject private var store = GameStore()

    var body: some View {
        TabView {
            Tab("遊戲庫", systemImage: "gamecontroller.fill") {
                GameLibraryView(games: $store.games)
            }
            Tab("我的收藏", systemImage: "heart.fill") {
                FavoritesView(games: $store.games)
            }
            Tab("遊戲統計", systemImage: "chart.bar.fill") {
                StatisticsView(games: store.games, onReset: store.resetToSamples)
            }
        }
        .tint(.indigo)
    }
}
