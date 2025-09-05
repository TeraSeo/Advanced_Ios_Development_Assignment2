import SwiftUI

struct FloatingActionButton: View {
    let action: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                
                Button(action: action) {
                    Image(systemName: "plus")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 64, height: 64)
                        .background(
                            Circle()
                                .fill(
                                    LinearGradient(
                                        gradient: Gradient(colors: [Color.blue, Color.purple]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .shadow(color: Color.blue.opacity(0.4), radius: 16, x: 0, y: 8)
                        )
                }
                .scaleEffect(1.0)
                .animation(.easeInOut(duration: 0.2), value: UUID())
            }
            .padding(.trailing, 20)
            .padding(.bottom, 34)
        }
    }
}
