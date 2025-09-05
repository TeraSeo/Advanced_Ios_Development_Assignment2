import SwiftUI

struct PlansCard: View {
    @Binding var plans: [Plan]
    @Binding var planTitle: String
    @Binding var planTime: Date
    @Binding var selectedCategory: BudgetCategory
    @Binding var planAmount: String
    @Binding var categorySpecificDetail: String
    @Binding var validationErrors: [String]
    
    let startDate: Date
    let endDate: Date
    let onAddPlan: () -> Void
    
    var categoryPlaceholder: String {
        switch selectedCategory {
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
    
    var body: some View {
        CardView(icon: "list.bullet.clipboard.fill", title: "Itinerary Plans", color: .indigo) {
            VStack(spacing: 16) {
                
                // Existing Plans
                if !plans.isEmpty {
                    VStack(spacing: 12) {
                        ForEach(plans) { plan in
                            HStack {
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(plan.time, style: .date)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                    Text(plan.time, style: .time)
                                        .font(.caption2)
                                        .foregroundColor(.secondary)
                                }
                                .frame(width: 80, alignment: .leading)
                                
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(plan.title)
                                        .font(.body)
                                        .fontWeight(.medium)
                                    Text(plan.budget.category.rawValue)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                    Text(plan.categorySpecificDetail)
                                        .font(.caption2)
                                        .foregroundColor(.secondary)
                                }
                                
                                Spacer()
                                
                                VStack(alignment: .trailing, spacing: 2) {
                                    Text("$\(plan.budget.amount, specifier: "%.0f")")
                                        .font(.body)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.green)
                                    
                                    Button(action: {
                                        if let index = plans.firstIndex(where: { $0.id == plan.id }) {
                                            plans.remove(at: index)
                                        }
                                    }) {
                                        Image(systemName: "trash.fill")
                                            .foregroundColor(.red)
                                            .font(.title3)
                                    }
                                }
                            }
                            .padding(.vertical, 8)
                            .padding(.horizontal, 12)
                            .background(Color(.systemGray6).opacity(0.5))
                            .cornerRadius(12)
                        }
                    }
                }
                
                // Add New Plan
                VStack(spacing: 12) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.indigo)
                            .font(.title3)
                        Text("Add New Plan")
                            .font(.subheadline)
                            .fontWeight(.medium)
                        Spacer()
                    }
                    
                    VStack(spacing: 12) {
                        // Title field
                        TextField("Plan title", text: $planTitle)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 16)
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                        
                        // Category Selection
                        HStack {
                            Text("Category:")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            Picker("Category", selection: $selectedCategory) {
                                ForEach(BudgetCategory.allCases, id: \.self) { category in
                                    HStack {
                                        Image(systemName: category.icon)
                                        Text(category.rawValue)
                                    }
                                    .tag(category)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .onChange(of: selectedCategory) { _ in
                                categorySpecificDetail = ""
                            }
                            
                            Spacer()
                        }
                        
                        // Category-specific detail field
                        TextField(categoryPlaceholder, text: $categorySpecificDetail)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 16)
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                        
                        // Amount field
                        HStack {
                            Text("Amount:")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            HStack(spacing: 4) {
                                Text("$")
                                    .font(.body)
                                    .foregroundColor(.secondary)
                                TextField("0", text: $planAmount)
                                    .keyboardType(.decimalPad)
                                    .multilineTextAlignment(.trailing)
                                    .font(.body)
                                    .fontWeight(.medium)
                            }
                            .frame(width: 100)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 12)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            
                            Spacer()
                        }
                        
                        // Date + Button
                        HStack(spacing: 12) {
                            DatePicker(
                                "",
                                selection: $planTime,
                                in: startDate.startOfDay ... endDate.endOfDay,
                                displayedComponents: [.date, .hourAndMinute]
                            )
                            .labelsHidden()
                            .padding(.vertical, 8)
                            .padding(.horizontal, 12)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            
                            Button(action: onAddPlan) {
                                Image(systemName: "plus")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .frame(width: 44, height: 44)
                                    .background(
                                        LinearGradient(
                                            gradient: Gradient(colors: [Color.indigo, Color.purple]),
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .cornerRadius(12)
                            }
                        }
                    }
                    
                    // Validation Error Messages
                    if !validationErrors.isEmpty {
                        VStack(alignment: .leading, spacing: 4) {
                            ForEach(validationErrors, id: \.self) { error in
                                Text(error)
                                    .font(.caption)
                                    .foregroundColor(.red)
                            }
                        }
                        .padding(.top, 8)
                    }
                }
            }
        }
    }
}
