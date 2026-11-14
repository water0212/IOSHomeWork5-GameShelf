import SwiftUI

struct GameDetailView: View {
    @Binding var game: Game

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                if geometry.size.width >= 700 {
                    HStack(alignment: .top, spacing: 28) {
                        GameDetailCoverSection(game: game)
                            .frame(maxWidth: 360)
                        GameDetailInfoSection(game: $game)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(30)
                } else {
                    VStack(alignment: .leading, spacing: 22) {
                        GameDetailCoverSection(game: game)
                        GameDetailInfoSection(game: $game)
                    }
                    .padding(18)
                }
            }
            .background {
                LinearGradient(
                    colors: [game.accent.color.opacity(0.12), Color(.systemGroupedBackground)],
                    startPoint: .top,
                    endPoint: .center
                )
                .ignoresSafeArea()
            }
        }
        .navigationTitle(game.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct GameDetailCoverSection: View {
    let game: Game

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            GameCoverView(game: game, height: 340, cornerRadius: 24)

            HStack(spacing: 10) {
                Label(game.genre, systemImage: "tag.fill")
                Label("\(game.releaseYear)", systemImage: "calendar")
            }
            .font(.subheadline)
            .foregroundStyle(.secondary)
        }
    }
}

private struct GameDetailInfoSection: View {
    @Binding var game: Game

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            VStack(alignment: .leading, spacing: 10) {
                Text(game.title)
                    .font(.largeTitle.bold())
                    .foregroundStyle(.primary)
                Text(game.description)
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .lineSpacing(4)
            }

            RatingCard(rating: $game.rating)
            FavoriteButton(isFavorite: $game.isFavorite)
            PlayDetailsCard(status: $game.status, playHours: $game.playHours)

            Label("變更會自動儲存", systemImage: "checkmark.icloud")
                .font(.caption)
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .center)
        }
    }
}

private struct RatingCard: View {
    @Binding var rating: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("我的評分", systemImage: "star.fill")
                .font(.headline)
                .foregroundStyle(.orange)

            StarRatingView(rating: $rating)

            HStack {
                Text(rating == 0 ? "尚未評分" : "\(rating) / 5 星")
                    .foregroundStyle(.secondary)
                Spacer()
                if rating != 0 {
                    Button("清除評分") { rating = 0 }
                        .buttonStyle(.borderless)
                }
            }
            .font(.caption)
        }
        .detailCardStyle()
    }
}

private struct FavoriteButton: View {
    @Binding var isFavorite: Bool
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        Button {
            withAnimation(reduceMotion ? nil : .spring(response: 0.34, dampingFraction: 0.65)) {
                isFavorite.toggle()
            }
        } label: {
            Label(
                isFavorite ? "已加入收藏" : "加入我的收藏",
                systemImage: isFavorite ? "heart.fill" : "heart"
            )
            .font(.headline)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 7)
            .symbolEffect(.bounce, value: isFavorite)
        }
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.roundedRectangle(radius: 14))
        .tint(isFavorite ? .pink : .indigo)
    }
}

private struct PlayDetailsCard: View {
    @Binding var status: GameStatus?
    @Binding var playHours: Int?

    private var hoursBinding: Binding<Int> {
        Binding(
            get: { playHours ?? 0 },
            set: { playHours = $0 }
        )
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            Label("遊玩紀錄", systemImage: "gamecontroller.fill")
                .font(.headline)
                .foregroundStyle(.indigo)

            Picker("遊玩狀態", selection: $status) {
                Text("尚未設定").tag(nil as GameStatus?)
                ForEach(GameStatus.allCases) { status in
                    Text(status.rawValue).tag(Optional(status))
                }
            }
            .pickerStyle(.menu)

            Divider()

            Stepper(value: hoursBinding, in: 0...9999) {
                VStack(alignment: .leading, spacing: 3) {
                    Label("遊玩時數", systemImage: "clock")
                    Text(playHours.map { "\($0) 小時" } ?? "尚未填寫")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }

            if playHours != nil {
                Button("清除遊玩時數", role: .destructive) { playHours = nil }
                    .font(.caption)
                    .buttonStyle(.borderless)
            }
        }
        .detailCardStyle()
    }
}

private extension View {
    func detailCardStyle() -> some View {
        padding(18)
            .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .stroke(.primary.opacity(0.06), lineWidth: 1)
            }
    }
}
