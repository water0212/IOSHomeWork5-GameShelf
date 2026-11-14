import SwiftUI

struct GameCoverView: View {
    let game: Game
    var height: CGFloat = 110

    var body: some View {
        ZStack {
            LinearGradient(colors: [game.accent.color, game.accent.color.opacity(0.5), .black],
                           startPoint: .topLeading, endPoint: .bottomTrailing)
            // 下載圖檔後由 Assets.xcassets 讀取；不存在時顯示系統圖示
            if UIImage(named: game.coverName) != nil {
                Image(game.coverName)
                    .resizable()
                    .scaledToFill()
            } else {
                Image(systemName: game.coverSymbol)
                    .font(.system(size: height * 0.33))
                    .foregroundStyle(.white)
            }
        }
        .frame(height: height)
        .frame(maxWidth: .infinity)
        .clipped()
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .accessibilityLabel("\(game.title) 的遊戲封面")
    }
}
