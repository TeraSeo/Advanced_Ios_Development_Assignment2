import SwiftUI

struct ValidationErrorsList: View {
    let validationErrors: [String]
    
    var body: some View {
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
