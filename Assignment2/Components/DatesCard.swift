import SwiftUI

struct DatesCard: View {
    @Binding var startDate: Date
    @Binding var endDate: Date
    let onDateChange: () -> Void
    
    var body: some View {
        CardView(icon: "calendar", title: "Travel Dates", color: .green) {
            VStack(spacing: 16) {
                HStack {
                    Image(systemName: "calendar.badge.plus")
                        .foregroundColor(.green)
                        .frame(width: 20)
                    DatePicker("Start", selection: $startDate, in: ...endDate, displayedComponents: .date)
                        .onChange(of: startDate) { _ in
                            onDateChange()
                        }
                }
                
                HStack {
                    Image(systemName: "calendar.badge.minus")
                        .foregroundColor(.red)
                        .frame(width: 20)
                    DatePicker("End", selection: $endDate, in: startDate..., displayedComponents: .date)
                        .onChange(of: endDate) { _ in
                            onDateChange()
                        }
                }
            }
        }
    }
}
