import SwiftUI


struct EditItineraryView: View {
    @Environment(\.dismiss) private var dismiss     // Dismiss view after save
    @ObservedObject var viewModel: ItineraryViewModel
    @State private var itinerary: Itinerary         // The itinerary being edited
    
    // Editable fields copied from itinerary
    @State private var destination = ""
    @State private var startDate = Date()
    @State private var endDate = Date().addingTimeInterval(3*24*60*60)
    @State private var plans: [Plan] = []
    
    // Fields for adding a new plan
    @State private var planTitle = ""
    @State private var planTime = Date().startOfDay
    @State private var selectedCategory: BudgetCategory = .accommodation
    @State private var planAmount = ""
    @State private var categorySpecificDetail = ""
    
    // Validation state
    @State private var validationErrors: [String] = []
    @State private var destinationError = false
    
    // Init ensures @State is set properly
    init(itinerary: Itinerary, viewModel: ItineraryViewModel) {
        self._itinerary = State(initialValue: itinerary)
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Header
                FormHeader(
                    title: "Edit Your Journey",
                    icon: "pencil.circle.fill"
                )
                
                VStack(spacing: 32) {
                    // Destination Card
                    DestinationCard(
                        destination: $destination,
                        destinationError: $destinationError
                    )
                    
                    // Dates Card
                    DatesCard(
                        startDate: $startDate,
                        endDate: $endDate,
                        onDateChange: {
                            // Remove plans that are outside the new date range
                            plans.removeAll { plan in
                                plan.time < startDate.startOfDay || plan.time > endDate.endOfDay
                            }
                            // Update planTime to start date
                            planTime = Calendar.current.startOfDay(for: startDate)
                        }
                    )
                    
                    // Budget Summary Card
                    BudgetSummaryCard(plans: plans)
                    
                    // Plans Card
                    PlansCard(
                        plans: $plans,
                        planTitle: $planTitle,
                        planTime: $planTime,
                        selectedCategory: $selectedCategory,
                        planAmount: $planAmount,
                        categorySpecificDetail: $categorySpecificDetail,
                        validationErrors: $validationErrors,
                        startDate: startDate,
                        endDate: endDate,
                        onAddPlan: addNewPlan
                    )
                    
                    // Save Button
                    SaveButton(title: "Save Changes") {
                        saveChanges()
                    }
                }
                .padding(.vertical, 32)
            }
        }
        .background(BackgroundGradient())
        .navigationTitle("Edit Trip")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            loadItineraryData()
        }
    }
    
    private func loadItineraryData() {
        destination = itinerary.destination
        startDate = itinerary.startDate
        endDate = itinerary.endDate
        plans = itinerary.plans
    }
    
    private func addNewPlan() {
        // Clear previous validation errors
        validationErrors.removeAll()
        
        // Validate fields
        if planTitle.isEmpty {
            validationErrors.append("Plan title is required")
        }
        
        if categorySpecificDetail.isEmpty {
            let placeholder = getCategoryPlaceholder(for: selectedCategory)
            validationErrors.append("\(placeholder) is required")
        }
        
        guard let amount = Double(planAmount) else {
            validationErrors.append("Valid amount is required")
            return
        }
        
        if amount < 0 {
            validationErrors.append("Amount cannot be negative")
            return
        }
        
        // If there are validation errors, don't proceed
        if !validationErrors.isEmpty {
            return
        }
        
        let budget: Budget
        switch selectedCategory {
        case .accommodation:
            budget = AccommodationBudget(amount: amount, hotelName: categorySpecificDetail)
        case .foodAndDrink:
            budget = FoodDrinkBudget(amount: amount, restaurantName: categorySpecificDetail)
        case .transport:
            budget = TransportBudget(amount: amount, transportType: categorySpecificDetail)
        case .extras:
            budget = ExtrasBudget(amount: amount, description: categorySpecificDetail)
        }
        
        let newPlan = Plan(
            title: planTitle,
            time: planTime,
            budget: budget,
            categorySpecificDetail: categorySpecificDetail
        )
        
        plans.append(newPlan)
        plans.sort { $0.time < $1.time }
        
        // Reset form
        planTitle = ""
        planAmount = ""
        categorySpecificDetail = ""
        planTime = newPlan.time
        validationErrors.removeAll()
    }
    
    private func getCategoryPlaceholder(for category: BudgetCategory) -> String {
        switch category {
        case .accommodation:
            return "Hotel name"
        case .foodAndDrink:
            return "Restaurant name"
        case .transport:
            return "Transport type (e.g., Flight, Train, Bus)"
        case .extras:
            return "Description"
        }
    }
    
    private func saveChanges() {
        destinationError = false
        
        if destination.isEmpty {
            destinationError = true
        } else {
            // Update the itinerary with new data
            itinerary.destination = destination
            itinerary.startDate = startDate
            itinerary.endDate = endDate
            itinerary.plans = plans
            
            // Update in view model
            if let index = viewModel.itineraries.firstIndex(where: { $0.id == itinerary.id }) {
                viewModel.itineraries[index] = itinerary
            }
            
            dismiss()
        }
    }
}
