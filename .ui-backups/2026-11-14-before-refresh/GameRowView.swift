import SwiftUI

struct GameRowView: View {
    let game: Game

    var body: some View {
        HStack(spacing: 14) {
            GameCoverView(game: game, height: 82)
                .frame(width: 70)

            VStack(alignment: .leading, spacing: 5) {
                Text(game.title)
                    .font(.headline)
                    .lineLimit(1)
                Text("\(game.genre) · \(game.releaseYear)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
                HStack(spacing: 7) {
                    if let status = game.status {
                        Label(status.rawValue, systemImage: status.systemImage)
                    } else {
                        Text("來設定一下這遊戲的資訊吧")
                    }
                    if game.rating > 0 {
                        Image(systemName: "star.fill")
                            .foregroundStyle(.yellow)
                        Text("\(game.rating)/5")
                    }
                }
                .font(.caption)
                .foregroundStyle(.secondary)
            }
            Spacer(minLength: 0)
            if game.isFavorite {
                Image(systemName: "heart.fill")
                    .foregroundStyle(.pink)
                    .accessibilityLabel("已收藏")
            }
        }
        .padding(.vertical, 3)
    }
}
