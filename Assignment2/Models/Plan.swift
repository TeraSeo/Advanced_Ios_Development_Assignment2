import Foundation

class Plan: Identifiable, Codable {
    let id: UUID
    var title: String
    var time: Date
    var budget: Budget
    var categorySpecificDetail: String
    
    init(title: String, time: Date, budget: Budget, categorySpecificDetail: String) {
        self.id = UUID()
        self.title = title
        self.time = time
        self.budget = budget
        self.categorySpecificDetail = categorySpecificDetail
    }
    
    var purpose: String {
        return budget.category.rawValue
    }
}
