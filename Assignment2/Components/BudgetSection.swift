import SwiftUI

struct BudgetSection: View {
    let totalBudget: Double
    let budgetBreakdown: [BudgetCategory: Double]
    
    var body: some View {
        VStack(spacing: 24) {
            
            // Budget Overview Card
            VStack(spacing: 20) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Total Budget")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        Text("$\(Int(totalBudget))")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(.primary)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(24)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(.systemBackground))
                    .shadow(color: Color.black.opacity(0.08), radius: 12, x: 0, y: 4)
            )
            .padding(.horizontal)
            .padding(.top, 24)
            
            // Budget Breakdown
            VStack(spacing: 16) {
                ForEach(BudgetCategory.allCases, id: \.self) { category in
                    let categoryTotal = budgetBreakdown[category] ?? 0
                    if categoryTotal > 0 {
                        BudgetRow(
                            title: category.rawValue,
                            value: categoryTotal,
                            color: colorForCategory(category),
                            icon: category.icon,
                            percentage: categoryTotal / totalBudget
                        )
                    }
                }
            }
            .padding(.horizontal)
        }
    }
    
    // Color for budget category
    func colorForCategory(_ category: BudgetCategory) -> Color {
        switch category {
        case .accommodation: return .purple
        case .foodAndDrink: return .orange
        case .transport: return .green
        case .extras: return .pink
        }
    }
}

// Budget Row Component
struct BudgetRow: View {
    let title: String
    let value: Double
    let color: Color
    let icon: String
    let percentage: Double
    
    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 16) {
                // Icon
                ZStack {
                    Circle()
                        .fill(color.opacity(0.1))
                        .frame(width: 48, height: 48)
                    
                    Image(systemName: icon)
                        .font(.title3)
                        .foregroundColor(color)
                }
                
                // Title and amount
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.body)
                        .fontWeight(.medium)
                    
                    Text("$\(Int(value))")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(color)
                }
                
                Spacer()
                
                // Percentage
                Text("\(Int(percentage * 100))%")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(color.opacity(0.1))
                    .cornerRadius(8)
                    .foregroundColor(color)
            }
            
            // Progress bar
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color(.systemGray6))
                        .frame(height: 6)
                        .cornerRadius(3)
                    
                    Rectangle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [color.opacity(0.7), color]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(width: geometry.size.width * percentage, height: 6)
                        .cornerRadius(3)
                        .animation(.easeInOut(duration: 0.8), value: percentage)
                }
            }
            .frame(height: 6)
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.04), radius: 6, x: 0, y: 2)
        )
    }
}
