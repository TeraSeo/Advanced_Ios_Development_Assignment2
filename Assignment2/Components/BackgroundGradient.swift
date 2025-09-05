import SwiftUI

struct BackgroundGradient: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [Color(.systemBackground), Color(.systemGray6).opacity(0.3)]),
            startPoint: .top,
            endPoint: .bottom
        )
    }
}
