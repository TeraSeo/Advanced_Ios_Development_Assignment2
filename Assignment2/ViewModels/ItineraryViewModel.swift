import Foundation

// ViewModel: connects Model <-> View in MVVM
// Manages itineraries and persists them with UserDefaults
class ItineraryViewModel: ObservableObject {
    
    // Published: updates UI whenever data changes
    @Published var itineraries: [Itinerary] = [] {
        didSet { saveItineraries() }
    }
    
    private let storageKey = "saved_itineraries"
    
    init() { loadItineraries() }
    
    // Create
    func saveItinerary(_ itinerary: Itinerary) {
        itineraries.append(itinerary)
    }
    
    // Persist data
    private func saveItineraries() {
        if let data = try? JSONEncoder().encode(itineraries) {
            UserDefaults.standard.set(data, forKey: storageKey)
        }
    }
    
    // Read
    private func loadItineraries() {
        if let data = UserDefaults.standard.data(forKey: storageKey),
           let decoded = try? JSONDecoder().decode([Itinerary].self, from: data) {
            itineraries = decoded
        }
    }
    
    // Delete
    func delete(itinerary: Itinerary) {
        if let index = itineraries.firstIndex(where: { $0.id == itinerary.id }) {
            itineraries.remove(at: index)
            saveItineraries()
        }
    }
}
