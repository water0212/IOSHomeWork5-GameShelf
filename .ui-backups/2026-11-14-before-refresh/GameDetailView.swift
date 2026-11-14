import SwiftUI

struct GameDetailView: View {
    @Binding var game: Game

    private var hoursBinding: Binding<Int> {
        Binding(get: { game.playHours ?? 0 }, set: { game.playHours = $0 })
    }

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                Group {
                    if geometry.size.width >= 700 {
                        HStack(alignment: .top, spacing: 30) {
                            coverSection.frame(maxWidth: 340)
                            infoSection.frame(maxWidth: .infinity, alignment: .leading)
                        }
                    } else {
                        VStack(alignment: .leading, spacing: 22) {
                            coverSection
                            infoSection
                        }
                    }
                }
                .padding(geometry.size.width >= 700 ? 30 : 18)
                .frame(maxWidth: 1000)
                .frame(maxWidth: .infinity)
            }
        }
        .navigationTitle(game.title)
        .navigationBarTitleDisplayMode(.inline)
    }

    private var coverSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            GameCoverView(game: game, height: 280)
            Label("\(game.genre) · \(game.releaseYear)", systemImage: "tag")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }

    private var infoSection: some View {
        VStack(alignment: .leading, spacing: 22) {
            Text(game.title)
                .font(.largeTitle.bold())
            Text(game.description)
                .foregroundStyle(.secondary)

            VStack(alignment: .leading, spacing: 7) {
                Text("我的評分")
                    .font(.headline)
                StarRatingView(rating: $game.rating)
                HStack {
                    Text(game.rating == 0 ? "尚未評分" : "\(game.rating) / 5 星")
                    Spacer()
                    if game.rating != 0 {
                        Button("清除評分") { game.rating = 0 }
                            .font(.caption)
                    }
                }
                .font(.caption)
                .foregroundStyle(.secondary)
            }

            Button {
                withAnimation(.spring(response: 0.34, dampingFraction: 0.5)) {
                    game.isFavorite.toggle()
                }
            } label: {
                Label(game.isFavorite ? "已加入收藏" : "加入我的收藏",
                      systemImage: game.isFavorite ? "heart.fill" : "heart")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .symbolEffect(.bounce, value: game.isFavorite)
            }
            .buttonStyle(.borderedProminent)
            .tint(game.isFavorite ? .pink : .indigo)

            Picker("遊玩狀態", selection: $game.status) {
                Text("尚未設定").tag(nil as GameStatus?)
                ForEach(GameStatus.allCases) { status in
                    Text(status.rawValue).tag(Optional(status))
                }
            }
            .pickerStyle(.menu)

            Stepper(value: hoursBinding, in: 0...9999) {
                Label(game.playHours.map { "遊玩時數：\($0) 小時" } ?? "遊玩時數：尚未填寫", systemImage: "clock")
            }
            if game.playHours != nil {
                Button("清除遊玩時數") { game.playHours = nil }
                    .font(.caption)
            }

            Text("評分、收藏、狀態和遊玩時數修改後會自動儲存。")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}
