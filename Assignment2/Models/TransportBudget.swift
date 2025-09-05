import Foundation

// Subclass representing transport expenses
class TransportBudget: Budget {
    var transportType: String
    
    init(amount: Double, transportType: String) {
        self.transportType = transportType
        super.init(amount: amount, category: .transport)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        transportType = try container.decode(String.self, forKey: .transportType)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(transportType, forKey: .transportType)
        try super.encode(to: encoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case transportType
    }
}
