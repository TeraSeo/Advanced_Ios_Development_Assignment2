import Foundation

// Subclass representing food & drink expenses
class FoodDrinkBudget: Budget {
    var restaurantName: String
    
    init(amount: Double, restaurantName: String) {
        self.restaurantName = restaurantName
        super.init(amount: amount, category: .foodAndDrink)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        restaurantName = try container.decode(String.self, forKey: .restaurantName)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(restaurantName, forKey: .restaurantName)
        try super.encode(to: encoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case restaurantName
    }
}
