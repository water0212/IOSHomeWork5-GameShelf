import SwiftUI

struct StarRatingView: View {
    @Binding var rating: Int

    var body: some View {
        HStack(spacing: 10) {
            ForEach(1...5, id: \.self) { star in
                Button {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.45)) {
                        rating = star
                    }
                } label: {
                    Image(systemName: star <= rating ? "star.fill" : "star")
                        .font(.system(size: 31))
                        .foregroundStyle(star <= rating ? Color.yellow : Color.secondary)
                        .scaleEffect(star == rating ? 1.15 : 1)
                        .symbolEffect(.bounce, value: rating)
                        .frame(minWidth: 39, minHeight: 44)
                }
                .buttonStyle(.plain)
                .accessibilityLabel("評分 \(star) 星")
            }
        }
        .accessibilityElement(children: .contain)
    }
}
