import SwiftUI

struct StatisticsView: View {
    let games: [Game]
    let onReset: () -> Void
    @State private var animateBars = false
    @State private var showResetConfirmation = false
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

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
                    StatisticsSummaryGrid(
                        gameCount: games.count,
                        completedCount: completedCount,
                        totalHours: totalHours,
                        averageRating: averageRating
                    )

                    StatusDistributionCard(games: games, animateBars: animateBars)

                    Label("未設定狀態的遊戲不會列入分類！", systemImage: "info.circle")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .padding()
                .frame(maxWidth: 900)
                .frame(maxWidth: .infinity)
            }
            .background(Color(.systemGroupedBackground))
            .safeAreaPadding(.bottom, 96)
            .navigationTitle("遊戲統計")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Button("清除玩家紀錄", role: .destructive) {
                            showResetConfirmation = true
                        }
                    } label: {
                        Label("更多", systemImage: "ellipsis.circle")
                    }
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
                withAnimation(reduceMotion ? nil : .easeOut(duration: 0.8)) {
                    animateBars = true
                }
            }
        }
    }
}

private struct StatisticsSummaryGrid: View {
    let gameCount: Int
    let completedCount: Int
    let totalHours: Int
    let averageRating: Double

    private let columns = [GridItem(.adaptive(minimum: 145), spacing: 12)]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 12) {
            StatisticCard(title: "遊戲總數", value: "\(gameCount)", icon: "gamecontroller.fill", tint: .indigo)
            StatisticCard(title: "已通關", value: "\(completedCount)", icon: "checkmark.seal.fill", tint: .green)
            StatisticCard(title: "遊玩時數", value: "\(totalHours) h", icon: "clock.fill", tint: .orange)
            StatisticCard(
                title: "平均評分",
                value: averageRating.formatted(.number.precision(.fractionLength(1))) + " / 5",
                icon: "star.fill",
                tint: .yellow
            )
        }
    }
}

private struct StatisticCard: View {
    let title: String
    let value: String
    let icon: String
    let tint: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(tint)
                .frame(width: 42, height: 42)
                .background(tint.opacity(0.12), in: RoundedRectangle(cornerRadius: 12, style: .continuous))
            Text(value)
                .font(.title2.bold())
                .contentTransition(.numericText())
            Text(title)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, minHeight: 132, alignment: .leading)
        .padding(16)
        .background(.background, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .stroke(.primary.opacity(0.06), lineWidth: 1)
        }
    }
}

private struct StatusDistributionCard: View {
    let games: [Game]
    let animateBars: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("遊玩狀態分布")
                .font(.title2.bold())

            ForEach(GameStatus.allCases) { status in
                StatusProgressRow(
                    status: status,
                    count: games.filter { $0.status == status }.count,
                    total: games.count,
                    animate: animateBars
                )
            }
        }
        .padding(20)
        .background(.background, in: RoundedRectangle(cornerRadius: 22, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .stroke(.primary.opacity(0.06), lineWidth: 1)
        }
    }
}

private struct StatusProgressRow: View {
    let status: GameStatus
    let count: Int
    let total: Int
    let animate: Bool

    private var color: Color {
        switch status {
        case .wishlist: .blue
        case .playing: .orange
        case .completed: .green
        }
    }

    private var progress: CGFloat {
        guard total > 0 else { return 0 }
        return CGFloat(count) / CGFloat(total)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 9) {
            HStack {
                Label(status.rawValue, systemImage: status.systemImage)
                    .foregroundStyle(color)
                Spacer()
                Text("\(count) / \(total)")
                    .foregroundStyle(.secondary)
                    .monospacedDigit()
            }
            .font(.subheadline.weight(.medium))

            GeometryReader { geometry in
                Capsule()
                    .fill(Color.secondary.opacity(0.12))
                    .overlay(alignment: .leading) {
                        Capsule()
                            .fill(color.gradient)
                            .frame(width: animate ? geometry.size.width * progress : 0)
                    }
            }
            .frame(height: 10)
        }
        .accessibilityElement(children: .combine)
        .accessibilityValue("\(count) 款，共 \(total) 款")
    }
}
