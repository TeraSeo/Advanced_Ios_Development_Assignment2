import SwiftUI

struct ExistingPlansSection: View {
    @Binding var plans: [Plan]
    
    var body: some View {
        VStack(spacing: 12) {
            ForEach(plans) { plan in
                PlanRow(plan: plan) {
                    if let index = plans.firstIndex(where: { $0.id == plan.id }) {
                        plans.remove(at: index)
                    }
                }
            }
        }
    }
}
