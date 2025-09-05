import Foundation

protocol ItineraryProtocol {
    var title: String { get set }
    var time: Date { get set }
    var cost: Double { get set }
    
    func summary() -> String
}

extension ItineraryProtocol {
    func summary() -> String {
        return "\(title) at \(time)"
    }
}
