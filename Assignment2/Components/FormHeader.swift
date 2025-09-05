import SwiftUI

struct FormHeader: View {
    let title: String
    let icon: String
    let gradientColors: [Color]
    
    init(title: String, icon: String, gradientColors: [Color] = [Color.blue.opacity(0.8), Color.purple.opacity(0.6)]) {
        self.title = title
        self.icon = icon
        self.gradientColors = gradientColors
    }
    
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: gradientColors),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .frame(height: 120)
        .overlay(
            VStack {
                Image(systemName: icon)
                    .font(.system(size: 40))
                    .foregroundColor(.white)
                Text(title)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
        )
        .clipShape(RoundedRectangle(cornerRadius: 0))
    }
}
