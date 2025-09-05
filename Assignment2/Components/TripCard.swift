import SwiftUI

struct TripCard: View {
    let itinerary: Itinerary
    let onRemove: () -> Void
    let onEdit: () -> Void
    @State private var isPressed = false
    
    var tripDuration: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: itinerary.startDate, to: itinerary.endDate)
        return (components.day ?? 0) + 1
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            NavigationLink(destination: ItineraryDetailView(itinerary: itinerary)) {
                ZStack {
                    // Background card
                    RoundedRectangle(cornerRadius: 24)
                        .fill(Color(.systemBackground))
                        .shadow(color: Color.black.opacity(0.08), radius: 16, x: 0, y: 8)
                    
                    VStack(spacing: 0) {
                        // Header with gradient
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(
                                    LinearGradient(
                                        gradient: Gradient(colors: gradientColors),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(height: 120)
                            
                            // Destination pattern
                            HStack {
                                Spacer()
                                Image(systemName: "airplane.departure")
                                    .font(.system(size: 40))
                                    .foregroundColor(.white.opacity(0.15))
                                    .rotationEffect(.degrees(15))
                                    .offset(x: 20, y: -10)
                            }
                            
                            // Content
                            VStack(spacing: 8) {
                                HStack {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(itinerary.destination)
                                            .font(.title2)
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                            .lineLimit(2)
                                        
                                        HStack {
                                            Image(systemName: "calendar")
                                                .font(.caption)
                                            Text("\(tripDuration) days")
                                                .font(.caption)
                                                .fontWeight(.medium)
                                        }
                                        .foregroundColor(.white.opacity(0.9))
                                    }
                                    
                                    Spacer()
                                }
                                .padding(.horizontal, 20)
                                .padding(.top, 16)
                                
                                Spacer()
                            }
                        }
                        
                        // Bottom section
                        VStack(spacing: 16) {
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Dates")
                                        .font(.caption)
                                        .fontWeight(.medium)
                                        .foregroundColor(.secondary)
                                    
                                    Text("\(formattedDateShort(itinerary.startDate)) - \(formattedDateShort(itinerary.endDate))")
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                        .foregroundColor(.primary)
                                }
                                
                                Spacer()
                                
                                VStack(alignment: .trailing, spacing: 4) {
                                    Text("Budget")
                                        .font(.caption)
                                        .fontWeight(.medium)
                                        .foregroundColor(.secondary)
                                    
                                    Text("$\(Int(itinerary.totalBudget))")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                        .foregroundColor(.green)
                                }
                            }
                            
                            // Plans preview
                            if !itinerary.plans.isEmpty {
                                HStack {
                                    Image(systemName: "list.bullet")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                    
                                    Text("\(itinerary.plans.count) activities planned")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                    
                                    Spacer()
                                    
                                    // Activity type indicators
                                    HStack(spacing: 4) {
                                        ForEach(Array(Set(itinerary.plans.map { $0.budget.category })).prefix(3), id: \.self) { category in
                                            Circle()
                                                .fill(colorForCategory(category))
                                                .frame(width: 8, height: 8)
                                        }
                                    }
                                }
                            }
                        }
                        .padding(20)
                    }
                }
                .scaleEffect(isPressed ? 0.98 : 1.0)
                .animation(.easeInOut(duration: 0.1), value: isPressed)
            }
            
            // Edit and Delete buttons (상단 오른쪽)
            HStack(spacing: 8) {
                // Edit button
                Button(action: onEdit) {
                    Image(systemName: "pencil.circle.fill")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.blue)
                        .padding(8)
                }
                
                // Delete button
                Button(action: onRemove) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.red)
                        .padding(8)
                }
            }
        }
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.1)) {
                isPressed = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.easeInOut(duration: 0.1)) {
                    isPressed = false
                }
            }
        }
    }
    
    // Generate gradient colors based on destination
    var gradientColors: [Color] {
        let hash = abs(itinerary.destination.hashValue)
        let colorSets: [[Color]] = [
            [.blue, .purple],
            [.purple, .pink],
            [.orange, .red],
            [.green, .blue],
            [.indigo, .purple],
            [.pink, .orange],
            [.blue, .cyan],
            [.purple, .blue]
        ]
        return colorSets[hash % colorSets.count]
    }
    
    func colorForCategory(_ category: BudgetCategory) -> Color {
        switch category {
        case .accommodation: return .purple
        case .foodAndDrink: return .orange
        case .transport: return .green
        case .extras: return .pink
        }
    }
    
    func formattedDateShort(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        return formatter.string(from: date)
    }
}
