import SwiftUI

struct AddNewPlanSection: View {
    @Binding var planTitle: String
    @Binding var selectedCategory: BudgetCategory
    @Binding var categorySpecificDetail: String
    @Binding var planAmount: String
    @Binding var planTime: Date
    @Binding var validationErrors: [String]
    let startDate: Date
    let endDate: Date
    let categoryPlaceholder: String
    let onAddPlan: () -> Void
    
    var body: some View {
        VStack(spacing: 12) {
            // Header
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
                CategoryPickerRow(selectedCategory: $selectedCategory, categorySpecificDetail: $categorySpecificDetail)
                
                // Category-specific detail field
                TextField(categoryPlaceholder, text: $categorySpecificDetail)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 16)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                
                // Amount field
                AmountInputRow(planAmount: $planAmount)
                
                // Date + Button
                DateTimeActionRow(
                    planTime: $planTime,
                    startDate: startDate,
                    endDate: endDate,
                    onAddPlan: onAddPlan
                )
            }
            
            // Validation Error Messages
            ValidationErrorsList(validationErrors: validationErrors)
        }
    }
}
