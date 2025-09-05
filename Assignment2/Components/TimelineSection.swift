import SwiftUI

struct TimelineSection: View {
    let plans: [Plan]
    let isSearchEmpty: Bool
    let onAddTrip: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            if plans.isEmpty {
                EmptyStateView(isSearchEmpty: isSearchEmpty, onAddTrip: onAddTrip)
                    .padding(.top, 40)
            } else {
                VStack(spacing: 16) {
                    ForEach(Array(plans.enumerated()), id: \.element.id) { index, plan in
                        PlanCard(plan: plan, isLast: index == plans.count - 1)
                    }
                }
                .padding(.top, 24)
            }
        }
    }
}
