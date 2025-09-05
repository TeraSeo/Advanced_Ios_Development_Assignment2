import SwiftUI

struct DestinationCard: View {
    @Binding var destination: String
    @Binding var destinationError: Bool
    
    var body: some View {
        CardView(icon: "location.fill", title: "Destination", color: .blue) {
            VStack(alignment: .leading, spacing: 8) {
                TextField("Where are you going?", text: $destination)
                    .font(.body)
                    .padding(.vertical, 4)
                    .onChange(of: destination) { _ in
                        destinationError = false
                    }
                
                if destinationError {
                    Text("Destination is required")
                        .font(.caption)
                        .foregroundColor(.red)
                }
            }
        }
    }
}
