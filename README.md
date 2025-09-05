# Assignment2 - Travel Itinerary Planner

A comprehensive iOS travel itinerary planning application built with SwiftUI, featuring budget management, plan organization, and an intuitive user interface.

## 📱 Features

### Core Functionality
- **Itinerary Management**: Create, edit, and delete travel itineraries
- **Budget Planning**: Category-based budget tracking with inheritance structure
- **Plan Organization**: Add detailed plans with specific categories and requirements
- **Search & Filter**: Find itineraries quickly with real-time search
- **Data Persistence**: Automatic saving using UserDefaults and JSON encoding

### Budget Categories
The app supports four distinct budget categories with specific requirements:

1. **Accommodation** 🏨
   - Hotel name field
   - Purple theme color
   - Bed icon

2. **Food & Drink** 🍽️
   - Restaurant name field
   - Red theme color
   - Fork and knife icon

3. **Transport** 🚗
   - Transport type field
   - Blue theme color
   - Car icon

4. **Extras** 🎁
   - Description field
   - Pink theme color
   - Gift icon

### User Interface
- **Modern Design**: Clean, intuitive SwiftUI interface
- **Component-Based Architecture**: Reusable UI components
- **Responsive Layout**: Adapts to different screen sizes
- **Visual Feedback**: Animations and state indicators
- **Empty States**: Helpful guidance when no data exists

## 🏗️ Architecture

### Data Models

#### Budget System (Inheritance-Based)
```swift
// Base Budget class
class Budget: Codable {
    let id: UUID
    var amount: Double
    var category: BudgetCategory
}

// Specialized budget classes
class AccommodationBudget: Budget {
    var hotelName: String
}

class FoodDrinkBudget: Budget {
    var restaurantName: String
}

class TransportBudget: Budget {
    var transportType: String
}

class ExtrasBudget: Budget {
    var description: String
}
```

#### Core Models
- **Itinerary**: Contains destination, dates, and plans
- **Plan**: Individual activities with budget and category details
- **BudgetCategory**: Enum defining the four budget types

### Component Architecture
The app uses a component-based architecture with reusable SwiftUI views:

#### Form Components
- `FormHeader`: Reusable header with gradient background
- `DestinationCard`: Destination input with validation
- `DatesCard`: Date range selection
- `BudgetSummaryCard`: Budget breakdown display
- `PlansCard`: Plan management interface
- `SaveButton`: Consistent save/submit button

#### List Components
- `HeaderSection`: Main list header with search
- `EmptyStateView`: Empty state with call-to-action
- `TripCard`: Individual itinerary display
- `FloatingActionButton`: Add new itinerary button

#### Detail Components
- `HeroHeader`: Itinerary overview section
- `TabButton`: Tab selection interface
- `TimelineSection`: Plan timeline display
- `BudgetSection`: Budget overview and breakdown
- `PlanCard`: Individual plan display

## 🚀 Getting Started

### Prerequisites
- Xcode 15.0 or later
- iOS 17.0 or later
- Swift 5.9 or later

### Installation
1. Clone the repository
2. Open `Assignment2.xcodeproj` in Xcode
3. Build and run the project

### Project Structure
```
Assignment2/
├── Assignment2/
│   ├── Models/
│   │   ├── Budget.swift
│   │   ├── Itinerary.swift
│   │   └── Plan.swift
│   ├── Protocols/
│   │   └── ItineraryProtocol.swift
│   ├── ViewModels/
│   │   └── ItineraryViewModel.swift
│   ├── Views/
│   │   ├── Components/
│   │   │   ├── FormHeader.swift
│   │   │   ├── DestinationCard.swift
│   │   │   ├── DatesCard.swift
│   │   │   ├── BudgetSummaryCard.swift
│   │   │   ├── PlansCard.swift
│   │   │   ├── SaveButton.swift
│   │   │   ├── HeaderSection.swift
│   │   │   ├── EmptyStateView.swift
│   │   │   ├── TripCard.swift
│   │   │   ├── FloatingActionButton.swift
│   │   │   ├── HeroHeader.swift
│   │   │   ├── TabButton.swift
│   │   │   ├── TimelineSection.swift
│   │   │   ├── BudgetSection.swift
│   │   │   └── PlanCard.swift
│   │   ├── AddItineraryView.swift
│   │   ├── EditItineraryView.swift
│   │   ├── ItineraryDetailView.swift
│   │   └── ItineraryListView.swift
│   ├── Assignment2App.swift
│   └── ContentView.swift
├── Assignment2Tests/
│   └── Assignment2Tests.swift
└── Assignment2UITests/
    └── Assignment2UITests.swift
```

## 🎯 Usage

### Creating an Itinerary
1. Tap the "+" button or "Create First Trip" (if no itineraries exist)
2. Enter destination name
3. Select start and end dates
4. Add plans with specific categories and details
5. Tap "Create My Journey" to save

### Adding Plans
1. Open an itinerary for editing
2. Fill in plan details:
   - **Title**: Plan name
   - **Category**: Select from Accommodation, Food & Drink, Transport, or Extras
   - **Category-specific field**: Hotel name, restaurant name, transport type, or description
   - **Amount**: Budget amount (0 or positive values allowed)
   - **Date/Time**: When the plan occurs
3. Tap the "+" button to add the plan

### Editing Itineraries
1. Tap the pencil icon on any itinerary card
2. Modify destination, dates, or plans
3. Tap "Save Changes" to update

### Viewing Details
1. Tap on any itinerary card to view details
2. Switch between "Timeline" and "Budget" tabs
3. View plan timeline and budget breakdown

## 🧪 Testing

The project includes comprehensive UI tests covering:

### Core Functionality Tests
- Creating new itineraries
- Editing existing itineraries
- Adding and managing plans
- Budget validation and display
- Search functionality
- Navigation between views

### Validation Tests
- Empty destination validation
- Plan field validation
- Amount validation (negative values rejected, zero allowed)
- Category-specific field validation

### UI State Tests
- Empty state handling
- Tab switching
- Button interactions
- Form validation feedback

### Running Tests
```bash
# Run all tests
xcodebuild test -scheme Assignment2 -destination 'platform=iOS Simulator,name=iPhone 15'

# Run specific test class
xcodebuild test -scheme Assignment2 -destination 'platform=iOS Simulator,name=iPhone 15' -only-testing:Assignment2UITests
```

## 🔧 Technical Details

### Data Persistence
- Uses `UserDefaults` for data storage
- JSON encoding/decoding for complex objects
- Automatic saving on app state changes

### State Management
- `@State` for local view state
- `@ObservedObject` for shared view models
- `@Binding` for two-way data flow

### Validation
- Inline validation with real-time feedback
- Red error messages for invalid inputs
- Prevents saving with invalid data

### Performance
- Lazy loading of views
- Efficient list rendering
- Optimized image and icon usage

## 🎨 Design Principles

### User Experience
- **Intuitive Navigation**: Clear flow between screens
- **Visual Feedback**: Immediate response to user actions
- **Error Prevention**: Validation before submission
- **Accessibility**: VoiceOver support and semantic labels

### Code Quality
- **Component Reusability**: Modular UI components
- **Separation of Concerns**: Clear model-view separation
- **Type Safety**: Strong typing with Swift
- **Documentation**: Comprehensive code comments

## 🔮 Future Enhancements

### Potential Features
- **Cloud Sync**: iCloud integration for data backup
- **Sharing**: Export itineraries as PDF or share with others
- **Maps Integration**: Location-based plan suggestions
- **Currency Support**: Multi-currency budget tracking
- **Photo Attachments**: Add photos to plans
- **Collaboration**: Share itineraries with travel companions

### Technical Improvements
- **Core Data**: More robust data persistence
- **Networking**: API integration for travel data
- **Offline Support**: Enhanced offline functionality
- **Performance**: Further optimization for large datasets

## 📄 License

This project is part of an academic assignment for Advanced iOS Development at UTS.

## 👨‍💻 Author

**서태준 (Seo Taejun)**
- Advanced iOS Development Assignment 2
- University of Technology Sydney

---

*Built with ❤️ using SwiftUI*
