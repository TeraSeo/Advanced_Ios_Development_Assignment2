import Foundation

// Base class for all budget categories
class Budget: Identifiable, Codable {
    let id: UUID
    var amount: Double
    var category: BudgetCategory
    
    init(amount: Double, category: BudgetCategory) {
        self.id = UUID()
        self.amount = amount
        self.category = category
    }
}
