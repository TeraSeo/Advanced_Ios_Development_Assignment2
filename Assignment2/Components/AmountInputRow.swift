import SwiftUI

struct AmountInputRow: View {
    @Binding var planAmount: String
    
    var body: some View {
        HStack {
            Text("Amount:")
                .font(.subheadline)
                .fontWeight(.medium)
            
            HStack(spacing: 4) {
                Text("$")
                    .font(.body)
                    .foregroundColor(.secondary)
                TextField("0", text: $planAmount)
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.trailing)
                    .font(.body)
                    .fontWeight(.medium)
            }
            .frame(width: 100)
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            
            Spacer()
        }
    }
}
