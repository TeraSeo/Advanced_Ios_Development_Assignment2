import SwiftUI

struct BudgetCategoryRow: View {
    let category: BudgetCategory
    let amount: Double
    
    var body: some View {
        HStack {
            Image(systemName: category.icon)
                .font(.title3)
                .foregroundColor(Color(category.color))
                .frame(width: 24)
            
            Text(category.rawValue)
                .font(.body)
                .fontWeight(.medium)
            
            Spacer()
            
            Text("$\(amount, specifier: "%.0f")")
                .font(.body)
                .fontWeight(.semibold)
                .foregroundColor(.green)
        }
    }
}
