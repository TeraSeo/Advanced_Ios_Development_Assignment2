import SwiftUI

struct PlanRow: View {
    let plan: Plan
    let onDelete: () -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text(plan.time, style: .date)
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(plan.time, style: .time)
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
            .frame(width: 80, alignment: .leading)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(plan.title)
                    .font(.body)
                    .fontWeight(.medium)
                Text(plan.budget.category.rawValue)
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(plan.categorySpecificDetail)
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 2) {
                Text("$\(plan.budget.amount, specifier: "%.0f")")
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundColor(.green)
                
                Button(action: onDelete) {
                    Image(systemName: "trash.fill")
                        .foregroundColor(.red)
                        .font(.title3)
                }
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(Color(.systemGray6).opacity(0.5))
        .cornerRadius(12)
    }
}
