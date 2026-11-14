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
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 290), spacing: 14)], spacing: 14) {
                            ForEach($games) { $game in
                                if isVisible(game) {
                                    NavigationLink {
                                        GameDetailView(game: $game)
                                    } label: {
                                        GameRowView(game: game)
                                            .padding(12)
                                            .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 16))
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }
                        .padding()
                    }
                } else {
                    List {
                        ForEach($games) { $game in
                            if isVisible(game) {
                                NavigationLink {
                                    GameDetailView(game: $game)
                                } label: {
                                    GameRowView(game: game)
                                }
                            }
                        }
                    }
                    .listStyle(.automatic)
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
                        Label("篩選", systemImage: "line.3.horizontal.decrease.circle")
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
