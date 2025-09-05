import Foundation

class Itinerary: Identifiable, Codable {
    let id: UUID
    var destination: String
    var startDate: Date
    var endDate: Date
    var plans: [Plan]
    
    init(destination: String, startDate: Date, endDate: Date, plans: [Plan] = []) {
        self.id = UUID()
        self.destination = destination
        self.startDate = startDate
        self.endDate = endDate
        self.plans = plans
    }
    
    var numberOfDays: Int {
        Calendar.current.dateComponents([.day], from: startDate, to: endDate).day ?? 0
    }
    
    var totalBudget: Double {
        plans.reduce(0) { $0 + $1.budget.amount }
    }
    
    var budgetBreakdown: [BudgetCategory: Double] {
        var breakdown: [BudgetCategory: Double] = [:]
        for plan in plans {
            let category = plan.budget.category
            breakdown[category, default: 0] += plan.budget.amount
        }
        return breakdown
    }
}
