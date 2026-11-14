import SwiftUI

struct FavoritesView: View {
    @Binding var games: [Game]

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                if geometry.size.width >= 700 {
                    FavoriteGamesGrid(games: $games, compactHeight: geometry.size.height < 500)
                } else {
                    FavoriteGamesList(games: $games)
                }
            }
            .navigationTitle("我的收藏")
            .overlay {
                if !games.contains(where: { $0.isFavorite }) {
                    ContentUnavailableView {
                        Label("尚無收藏遊戲", systemImage: "heart")
                    } description: {
                        Text("前往遊戲詳情，按下愛心加入收藏。")
                    }
                }
            }
        }
    }
}

private struct FavoriteGamesList: View {
    @Binding var games: [Game]

    var body: some View {
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
        .listStyle(.insetGrouped)
        .safeAreaPadding(.bottom, 76)
    }
}

private struct FavoriteGamesGrid: View {
    @Binding var games: [Game]
    let compactHeight: Bool
    private let columns = [GridItem(.adaptive(minimum: 230, maximum: 300), spacing: 18)]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 18) {
                ForEach($games) { $game in
                    if game.isFavorite {
                        NavigationLink {
                            GameDetailView(game: $game)
                        } label: {
                            GameGridCardView(game: game, coverHeight: compactHeight ? 128 : 178)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .padding(24)
        }
        .background(Color(.systemGroupedBackground))
        .safeAreaPadding(.bottom, 88)
    }
}
