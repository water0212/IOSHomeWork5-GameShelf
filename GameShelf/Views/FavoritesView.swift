import SwiftUI

struct FavoritesView: View {
    @Binding var games: [Game]

    var body: some View {
        NavigationStack {
            List {
                ForEach($games) { $game in
                    if game.isFavorite {
                        NavigationLink {
                            GameDetailView(game: $game)
                        } label: {
                            GameRowView(game: game)
                        }
                    }
                }
            }
            .listStyle(.automatic)
            .navigationTitle("我的收藏")
            .overlay {
                if !games.contains(where: { $0.isFavorite }) {
                    ContentUnavailableView("尚無收藏遊戲", systemImage: "heart",
                                           description: Text("前往遊戲詳情，按下愛心加入收藏。"))
                }
            }
        }
    }
}
