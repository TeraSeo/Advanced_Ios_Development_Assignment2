import SwiftUI

struct ItineraryDetailView: View {
    let itinerary: Itinerary
    @State private var selectedTab = 0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                
                // Hero Header Section
                HeroHeader(
                    destination: itinerary.destination,
                    startDate: itinerary.startDate,
                    endDate: itinerary.endDate
                )
                
                // Tab Selection
                HStack(spacing: 0) {
                    TabButton(title: "Timeline", icon: "clock.fill", isSelected: selectedTab == 0) {
                        selectedTab = 0
                    }
                    
                    TabButton(title: "Budget", icon: "chart.pie.fill", isSelected: selectedTab == 1) {
                        selectedTab = 1
                    }
                }
                .padding(.horizontal)
                .padding(.top, 24)
                
                // Content based on selected tab
                if selectedTab == 0 {
                    TimelineSection(
                        plans: itinerary.plans,
                        isSearchEmpty: false,
                        onAddTrip: {}
                    )
                } else {
                    BudgetSection(
                        totalBudget: itinerary.totalBudget,
                        budgetBreakdown: itinerary.budgetBreakdown
                    )
                }
                
                Spacer(minLength: 32)
            }
        }
        .background(
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(.systemBackground),
                    Color(.systemGray6).opacity(0.3)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    
}

