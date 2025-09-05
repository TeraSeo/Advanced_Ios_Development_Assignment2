import SwiftUI

struct CategoryPickerRow: View {
    @Binding var selectedCategory: BudgetCategory
    @Binding var categorySpecificDetail: String
    
    var body: some View {
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
    }
}
