import SwiftUI

struct PlanCard: View {
    let plan: Plan
    let isLast: Bool
    
    var body: some View {
        HStack(spacing: 0) {
            // Timeline connector
            VStack {
                Circle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [colorForCategory(plan.budget.category), colorForCategory(plan.budget.category).opacity(0.7)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 16, height: 16)
                    .overlay(
                        Circle()
                            .stroke(Color.white, lineWidth: 3)
                    )
                
                if !isLast {
                    Rectangle()
                        .fill(Color(.systemGray4))
                        .frame(width: 2, height: 40)
                }
            }
            .padding(.trailing, 16)
            
            // Plan content
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(plan.time, style: .date)   // 날짜
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Text(plan.time, style: .time)   // 시간
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 4) {
                        Text("$\(Int(plan.budget.amount))")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.green)
                        
                        Image(systemName: plan.budget.category.icon)
                            .font(.callout)
                            .foregroundColor(colorForCategory(plan.budget.category))
                            .padding(8)
                            .background(colorForCategory(plan.budget.category).opacity(0.1))
                            .cornerRadius(8)
                    }
                }
                
                Text(plan.title)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                
                HStack {
                    Text(plan.budget.category.rawValue)
                        .font(.caption)
                        .fontWeight(.medium)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(colorForCategory(plan.budget.category).opacity(0.1))
                        .foregroundColor(colorForCategory(plan.budget.category))
                        .cornerRadius(6)
                    
                    Spacer()
                }
                
                if !plan.categorySpecificDetail.isEmpty {
                    Text(plan.categorySpecificDetail)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding(.top, 4)
                }
            }
            .padding(.vertical, 16)
            .padding(.horizontal, 20)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.systemBackground))
                    .shadow(color: Color.black.opacity(0.06), radius: 8, x: 0, y: 3)
            )
            
            Spacer()
        }
        .padding(.horizontal)
    }
    
    // Helper function
    func colorForCategory(_ category: BudgetCategory) -> Color {
        switch category {
        case .accommodation: return .purple
        case .foodAndDrink: return .orange
        case .transport: return .green
        case .extras: return .pink
        }
    }
}
