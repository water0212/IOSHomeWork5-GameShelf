import SwiftUI

struct GameRowView: View {
    let game: Game

    var body: some View {
        HStack(spacing: 14) {
            GameCoverView(game: game, height: 88, cornerRadius: 12)
                .frame(width: 68)

            VStack(alignment: .leading, spacing: 5) {
                Text(game.title)
                    .font(.headline)
                    .lineLimit(1)
                Text(verbatim: "\(game.genre) · \(game.releaseYear)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
                HStack(spacing: 8) {
                    if let status = game.status {
                        GameStatusBadge(status: status)
                    } else {
                        Text("來設定一下這遊戲的資訊吧")
                            .foregroundStyle(.tertiary)
                    }
                    if game.rating > 0 {
                        Label("\(game.rating)/5", systemImage: "star.fill")
                            .foregroundStyle(.orange)
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

struct GameGridCardView: View {
    let game: Game
    var coverHeight: CGFloat = 178

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            GameCoverView(game: game, height: coverHeight, cornerRadius: 18)

            VStack(alignment: .leading, spacing: 6) {
                HStack(alignment: .firstTextBaseline) {
                    Text(game.title)
                        .font(.headline)
                        .lineLimit(1)
                    Spacer(minLength: 8)
                    if game.isFavorite {
                        Image(systemName: "heart.fill")
                            .foregroundStyle(.pink)
                            .accessibilityLabel("已收藏")
                    }
                }

                Text(verbatim: "\(game.genre) · \(game.releaseYear)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)

                HStack(spacing: 8) {
                    if let status = game.status {
                        GameStatusBadge(status: status)
                    } else {
                        Text("尚未設定")
                            .font(.caption)
                            .foregroundStyle(.tertiary)
                    }
                    Spacer(minLength: 0)
                    if game.rating > 0 {
                        Label("\(game.rating)", systemImage: "star.fill")
                            .font(.caption.weight(.semibold))
                            .foregroundStyle(.orange)
                    }
                }
            }
        }
        .padding(12)
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 22, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .stroke(.primary.opacity(0.06), lineWidth: 1)
        }
    }
}

struct GameStatusBadge: View {
    let status: GameStatus

    var body: some View {
        Label(status.rawValue, systemImage: status.systemImage)
            .font(.caption.weight(.medium))
            .foregroundStyle(status.color)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(status.color.opacity(0.12), in: Capsule())
    }
}

private extension GameStatus {
    var color: Color {
        switch self {
        case .wishlist: .blue
        case .playing: .orange
        case .completed: .green
        }
    }
}
