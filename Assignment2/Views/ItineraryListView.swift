import SwiftUI

struct ItineraryListView: View {
    @StateObject private var viewModel = ItineraryViewModel()   // Data manager
    @State private var searchText = ""                          // Search filter
    @State private var showingAdd = false                       // Add sheet toggle
    @State private var selectedItineraryForEdit: Itinerary?     // Selected trip for edit
    
    // Filter itineraries by destination
    var filteredItineraries: [Itinerary] {
        searchText.isEmpty
        ? viewModel.itineraries
        : viewModel.itineraries.filter { $0.destination.localizedCaseInsensitiveContains(searchText) }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(.systemBackground),
                        Color.blue.opacity(0.02),
                        Color.purple.opacity(0.03)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ).ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        // Header with title + search
                        HeaderSection(
                            itineraryCount: viewModel.itineraries.count,
                            searchText: $searchText
                        )
                        
                        // Show trips or empty state
                        if filteredItineraries.isEmpty {
                            EmptyStateView(
                                isSearchEmpty: searchText.isEmpty,
                                onAddTrip: { showingAdd = true }
                            )
                        } else {
                            LazyVStack(spacing: 16) {
                                ForEach(filteredItineraries) { itinerary in
                                    TripCard(
                                        itinerary: itinerary,
                                        onRemove: { viewModel.delete(itinerary: itinerary) },
                                        onEdit: { selectedItineraryForEdit = itinerary }
                                    )
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                        Spacer(minLength: 100)
                    }
                }
            }
            .navigationBarHidden(true)
            // Add trip sheet
            .sheet(isPresented: $showingAdd) {
                NavigationView { AddItineraryView(viewModel: viewModel) }
            }
            // Edit trip sheet
            .sheet(item: $selectedItineraryForEdit) { itinerary in
                NavigationView { EditItineraryView(itinerary: itinerary, viewModel: viewModel) }
            }
            // Floating add button
            .overlay(FloatingActionButton(action: { showingAdd = true }))
        }
    }
    
    // Date formatting helper
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}
