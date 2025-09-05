import Foundation

// Subclass representing accommodation expenses
class AccommodationBudget: Budget {
    var hotelName: String
    
    init(amount: Double, hotelName: String) {
        self.hotelName = hotelName
        super.init(amount: amount, category: .accommodation)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        hotelName = try container.decode(String.self, forKey: .hotelName)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(hotelName, forKey: .hotelName)
        try super.encode(to: encoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case hotelName
    }
}
