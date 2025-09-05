import SwiftUI

struct BudgetTotalRow: View {
    let totalBudget: Double
    
    var body: some View {
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
    }
}
