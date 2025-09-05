import Foundation

// Subclass representing extras or miscellaneous expenses
class ExtrasBudget: Budget {
    var description: String
    
    init(amount: Double, description: String) {
        self.description = description
        super.init(amount: amount, category: .extras)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        description = try container.decode(String.self, forKey: .description)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(description, forKey: .description)
        try super.encode(to: encoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case description
    }
}
