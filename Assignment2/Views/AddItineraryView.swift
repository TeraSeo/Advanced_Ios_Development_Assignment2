import SwiftUI

struct AddItineraryView: View {
    @Environment(\.dismiss) private var dismiss     // Dismiss view after save
    @ObservedObject var viewModel: ItineraryViewModel
    
    // Form fields
    @State private var destination = ""
    @State private var startDate = Date()
    @State private var endDate = Date().addingTimeInterval(3*24*60*60)
    
    // Plan fields
    @State private var plans: [Plan] = []
    @State private var planTitle = ""
    @State private var planTime = Date().startOfDay
    @State private var selectedCategory: BudgetCategory = .accommodation
    @State private var planAmount = ""
    @State private var categorySpecificDetail = ""
    
    // Error states
    @State private var validationErrors: [String] = []
    @State private var destinationError = false
    
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                
                // Header
                FormHeader(
                    title: "Plan Your Journey",
                    icon: "airplane.departure"
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
                                        plans.removeAll()
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
                    SaveButton(title: "Create My Journey") {
                        destinationError = false
                        
                        if destination.isEmpty {
                            destinationError = true
                        } else {
                            let newItinerary = Itinerary(
                                destination: destination,
                                startDate: startDate,
                                endDate: endDate,
                                plans: plans
                            )
                            viewModel.saveItinerary(newItinerary)
                            dismiss()
                        }
                    }
                }
                .padding(.vertical, 32)
            }
        }
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color(.systemBackground), Color(.systemGray6).opacity(0.3)]),
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .navigationTitle("New Trip")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // Adds a new plan after validation
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
}

struct CardView<Content: View>: View {
    let icon: String
    let title: String
    let color: Color
    let content: Content
    
    init(icon: String, title: String, color: Color, @ViewBuilder content: () -> Content) {
        self.icon = icon
        self.title = title
        self.color = color
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(color)
                    .frame(width: 28, height: 28)
                    .background(color.opacity(0.1))
                    .cornerRadius(8)
                
                Text(title)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                
                Spacer()
            }
            
            content
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 2)
        )
        .padding(.horizontal)
    }
}

extension Date {
    var startOfDay: Date { Calendar.current.startOfDay(for: self) }
    var endOfDay: Date {
        Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: self)!
    }
}
