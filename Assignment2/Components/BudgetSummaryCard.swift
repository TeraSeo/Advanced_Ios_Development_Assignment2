import SwiftUI

struct BudgetSummaryCard: View {
    let plans: [Plan]
    
    var totalBudget: Double {
        plans.reduce(0) { $0 + $1.budget.amount }
    }
    
    var body: some View {
        CardView(icon: "dollarsign.circle.fill", title: "Budget Summary", color: .orange) {
            VStack(spacing: 16) {
                // Budget breakdown by category
                ForEach(BudgetCategory.allCases, id: \.self) { category in
                    let categoryTotal = plans.filter { $0.budget.category == category }.reduce(0) { $0 + $1.budget.amount }
                    if categoryTotal > 0 {
                        HStack {
                            Image(systemName: category.icon)
                                .font(.title3)
                                .foregroundColor(Color(category.color))
                                .frame(width: 24)
                            
                            Text(category.rawValue)
                                .font(.body)
                                .fontWeight(.medium)
                            
                            Spacer()
                            
                            Text("$\(categoryTotal, specifier: "%.0f")")
                                .font(.body)
                                .fontWeight(.semibold)
                                .foregroundColor(.green)
                        }
                    }
                }
                
                // Total Budget Display
                if !plans.isEmpty {
                    Divider()
                    HStack {
                        Text("Total Budget")
                            .font(.headline)
                            .fontWeight(.bold)
                        Spacer()
                        Text("$\(totalBudget, specifier: "%.0f")")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.green)
                    }
                    .padding(.top, 8)
                    .padding(.horizontal, 4)
                } else {
                    Text("Add plans to see budget breakdown")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .italic()
                }
            }
        }
    }
}
