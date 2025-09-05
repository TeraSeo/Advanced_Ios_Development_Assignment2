import SwiftUI

struct EmptyStateView: View {
    let isSearchEmpty: Bool
    let onAddTrip: () -> Void
    
    var body: some View {
        if isSearchEmpty {
            // Empty state for no trips
            VStack(spacing: 24) {
                Spacer()
                
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.blue.opacity(0.1), Color.purple.opacity(0.1)]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 120, height: 120)
                    
                    Image(systemName: "airplane.departure")
                        .font(.system(size: 48))
                        .foregroundColor(.blue.opacity(0.7))
                }
                
                VStack(spacing: 12) {
                    Text("Ready for Adventure?")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    Text("Create your first itinerary and start planning your dream trip!")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                }
                
                Button(action: onAddTrip) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .font(.title3)
                        Text("Create First Trip")
                            .font(.headline)
                            .fontWeight(.semibold)
                    }
                    .padding(.horizontal, 32)
                    .padding(.vertical, 16)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.blue, Color.purple]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .foregroundColor(.white)
                    .cornerRadius(25)
                    .shadow(color: Color.blue.opacity(0.3), radius: 12, x: 0, y: 6)
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 60)
        } else {
            // Empty search results
            VStack(spacing: 16) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 40))
                    .foregroundColor(.secondary)
                
                Text("No trips found")
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text("Try a different search term")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding(.top, 80)
        }
    }
}
