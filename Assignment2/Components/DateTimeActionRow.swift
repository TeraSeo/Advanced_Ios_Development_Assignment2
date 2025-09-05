import SwiftUI

struct DateTimeActionRow: View {
    @Binding var planTime: Date
    let startDate: Date
    let endDate: Date
    let onAddPlan: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            DatePicker(
                "",
                selection: $planTime,
                in: startDate.startOfDay ... endDate.endOfDay,
                displayedComponents: [.date, .hourAndMinute]
            )
            .labelsHidden()
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            
            Button(action: onAddPlan) {
                Image(systemName: "plus")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(width: 44, height: 44)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.indigo, Color.purple]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .cornerRadius(12)
            }
        }
    }
}
