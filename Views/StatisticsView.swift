import SwiftUI

struct StatisticsView: View {
    let games: [Game]
    let onReset: () -> Void
    @State private var animateBars = false
    @State private var showResetConfirmation = false

    private var completedCount: Int { games.filter { $0.status == .completed }.count }
    private var totalHours: Int { games.reduce(0) { $0 + ($1.playHours ?? 0) } }
    private var averageRating: Double {
        let rated = games.filter { $0.rating > 0 }
        guard !rated.isEmpty else { return 0 }
        return Double(rated.reduce(0) { $0 + $1.rating }) / Double(rated.count)
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 145), spacing: 12)], spacing: 12) {
                        statCard("遊戲總數", value: "\(games.count)", icon: "gamecontroller.fill", tint: .indigo)
                        statCard("已通關", value: "\(completedCount)", icon: "checkmark.seal.fill", tint: .green)
                        statCard("遊玩時數", value: "\(totalHours) h", icon: "clock.fill", tint: .orange)
                        statCard("平均評分", value: String(format: "%.1f / 5", averageRating), icon: "star.fill", tint: .yellow)
                    }
                    VStack(alignment: .leading, spacing: 20) {
                        Text("遊玩狀態分布")
                            .font(.title2.bold())
                        ForEach(GameStatus.allCases) { status in
                            let count = games.filter { $0.status == status }.count
                            VStack(alignment: .leading, spacing: 7) {
                                HStack {
                                    Label(status.rawValue, systemImage: status.systemImage)
                                    Spacer()
                                    Text("\(count) / \(games.count)")
                                        .foregroundStyle(.secondary)
                                }
                                GeometryReader { geo in
                                    Capsule()
                                        .fill(Color.secondary.opacity(0.13))
                                        .overlay(alignment: .leading) {
                                            Capsule()
                                                .fill(barColor(for: status).gradient)
                                                .frame(width: animateBars && !games.isEmpty
                                                       ? geo.size.width * CGFloat(count) / CGFloat(games.count)
                                                       : 0)
                                        }
                                }
                                .frame(height: 12)
                            }
                        }
                    }
                    .padding(18)
                    .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 20))
                    Text("未設定狀態的遊戲不列入分類，所有數據會即時更新。")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .padding()
                .frame(maxWidth: 860)
                .frame(maxWidth: .infinity)
            }
            .navigationTitle("遊戲統計")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("清除玩家紀錄") { showResetConfirmation = true }
                }
            }
            .confirmationDialog("要清除所有玩家紀錄嗎？", isPresented: $showResetConfirmation) {
                Button("清除全部紀錄", role: .destructive) { onReset() }
                Button("取消", role: .cancel) { }
            } message: {
                Text("評分、收藏、遊玩狀態和時數會全部清空，無法復原。")
            }
            .onAppear {
                animateBars = false
                withAnimation(.easeOut(duration: 0.9)) { animateBars = true }
            }
        }
    }

    private func barColor(for status: GameStatus) -> Color {
        switch status {
        case .wishlist: .blue
        case .playing: .orange
        case .completed: .green
        }
    }

    private func statCard(_ title: String, value: String, icon: String, tint: Color) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(tint)
            Text(value)
                .font(.title2.bold())
                .contentTransition(.numericText())
            Text(title)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, minHeight: 100, alignment: .leading)
        .padding(16)
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 18))
    }
}
