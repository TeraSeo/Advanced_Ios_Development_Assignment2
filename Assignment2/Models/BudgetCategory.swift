import Foundation

enum BudgetCategory: String, CaseIterable, Codable {
    case accommodation = "Accommodation"
    case foodAndDrink = "Food & Drink"
    case transport = "Transport"
    case extras = "Extras"
    
    var icon: String {
        switch self {
        case .accommodation: return "bed.double.fill"
        case .foodAndDrink: return "fork.knife"
        case .transport: return "car.fill"
        case .extras: return "gift.fill"
        }
    }
    
    var color: String {
        switch self {
        case .accommodation: return "purple"
        case .foodAndDrink: return "red"
        case .transport: return "blue"
        case .extras: return "pink"
        }
    }
}
