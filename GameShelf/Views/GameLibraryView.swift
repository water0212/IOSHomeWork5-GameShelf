import SwiftUI

struct GameLibraryView: View {
    @Binding var games: [Game]
    @State private var searchText = ""
    @State private var selectedStatus: GameStatus?

    private func isVisible(_ game: Game) -> Bool {
        (searchText.isEmpty || game.title.localizedCaseInsensitiveContains(searchText)
         || game.genre.localizedCaseInsensitiveContains(searchText))
        && (selectedStatus == nil || game.status == selectedStatus)
    }

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                if geometry.size.width >= 700 {
                    GameLibraryGrid(
                        games: $games,
                        compactHeight: geometry.size.height < 500,
                        isVisible: isVisible
                    )
                } else {
                    GameLibraryList(games: $games, isVisible: isVisible)
                }
            }
            .navigationTitle("我的遊戲庫")
            .searchable(text: $searchText, prompt: "搜尋遊戲名稱或類型")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Button("全部遊戲") { selectedStatus = nil }
                        ForEach(GameStatus.allCases) { status in
                            Button(status.rawValue) { selectedStatus = status }
                        }
                    } label: {
                        Label(selectedStatus?.rawValue ?? "篩選", systemImage: selectedStatus == nil
                              ? "line.3.horizontal.decrease.circle"
                              : "line.3.horizontal.decrease.circle.fill")
                    }
                }
            }
            .overlay {
                if !games.contains(where: isVisible) {
                    ContentUnavailableView.search(text: searchText)
                }
            }
        }
    }
}

private struct GameLibraryList: View {
    @Binding var games: [Game]
    let isVisible: (Game) -> Bool

    var body: some View {
        List {
            Section {
                ForEach($games) { $game in
                    if isVisible(game) {
                        NavigationLink {
                            GameDetailView(game: $game)
                        } label: {
                            GameRowView(game: game)
                        }
                    }
                }
            } header: {
                Text("共 \(games.filter(isVisible).count) 款遊戲")
            }
        }
        .listStyle(.insetGrouped)
        .safeAreaPadding(.bottom, 76)
    }
}

private struct GameLibraryGrid: View {
    @Binding var games: [Game]
    let compactHeight: Bool
    let isVisible: (Game) -> Bool

    private let columns = [GridItem(.adaptive(minimum: 230, maximum: 300), spacing: 18)]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                Text("共 \(games.filter(isVisible).count) 款遊戲")
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(.secondary)

                LazyVGrid(columns: columns, spacing: 18) {
                    ForEach($games) { $game in
                        if isVisible(game) {
                            NavigationLink {
                                GameDetailView(game: $game)
                            } label: {
                                GameGridCardView(game: game, coverHeight: compactHeight ? 128 : 178)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
            }
            .padding(24)
        }
        .background(Color(.systemGroupedBackground))
        .safeAreaPadding(.bottom, 88)
    }
}
