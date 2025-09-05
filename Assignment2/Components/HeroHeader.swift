import SwiftUI

struct HeroHeader: View {
    let destination: String
    let startDate: Date
    let endDate: Date
    
    var tripDuration: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: startDate, to: endDate)
        return (components.day ?? 0) + 1
    }
    
    var body: some View {
        ZStack {
            // Background gradient with destination image placeholder
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.blue.opacity(0.8),
                    Color.purple.opacity(0.9),
                    Color.pink.opacity(0.7)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .frame(height: 200)
            
            // Overlay pattern
            Image(systemName: "airplane.departure")
                .font(.system(size: 80))
                .foregroundColor(.white.opacity(0.1))
                .offset(x: 60, y: -30)
            
            // Content
            VStack(spacing: 16) {
                Spacer()
                
                HStack {
                    Image(systemName: "location.fill")
                        .font(.title2)
                        .foregroundColor(.white)
                    
                    Text(destination)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                HStack {
                    Image(systemName: "calendar")
                        .font(.callout)
                        .foregroundColor(.white.opacity(0.9))
                    
                    Text("\(formattedDate(startDate)) - \(formattedDate(endDate))")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.9))
                    
                    Spacer()
                    
                    Text("\(tripDuration) days")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(12)
                        .foregroundColor(.white)
                }
                .padding(.horizontal)
                
                Spacer()
            }
        }
        .clipShape(
            .rect(
                topLeadingRadius: 0,
                bottomLeadingRadius: 32,
                bottomTrailingRadius: 32,
                topTrailingRadius: 0
            )
        )
    }
    
    // Date formatting
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}
