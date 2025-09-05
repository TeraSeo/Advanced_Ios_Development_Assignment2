# Assignment2 - Travel Itinerary Planner

A SwiftUI-based iOS application for creating and managing travel itineraries with category-based budget planning.

## How to Use

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

### Managing Itineraries
- **Edit**: Tap the pencil icon on any itinerary card
- **Delete**: Tap the X icon on any itinerary card
- **View Details**: Tap on any itinerary card to view timeline and budget breakdown
- **Search**: Use the search bar to filter itineraries by destination

## Assessment Criteria

### 1. Concept Implementation: Effective integration of OOP and protocol-oriented concepts

**OOP Implementation:**
- **Inheritance**: `Budget` base class with specialized subclasses (`AccommodationBudget`, `FoodDrinkBudget`, `TransportBudget`, `ExtrasBudget`)
- **Encapsulation**: Private properties with public interfaces, data hiding through computed properties
- **Polymorphism**: Different budget types handled uniformly through base class interface
- **Abstraction**: Abstract `Budget` class defining common behavior

**Protocol-Oriented Design:**
- **ItineraryProtocol**: Defines contract for itinerary management operations
- **Codable Protocol**: Enables data persistence through JSON encoding/decoding
- **Identifiable Protocol**: Provides unique identification for SwiftUI list management

### 2. User Interface Design: Intuitive UI that enables users to manage tasks seamlessly

**Design Principles:**
- **Component-Based Architecture**: Reusable SwiftUI components for consistency
- **Visual Hierarchy**: Clear information organization with cards and sections
- **Responsive Layout**: Adapts to different screen sizes and orientations
- **Empty States**: Helpful guidance when no data exists
- **Visual Feedback**: Animations, state indicators, and immediate response to user actions

**User Experience:**
- **Intuitive Navigation**: Clear flow between list, detail, and edit views
- **Form Validation**: Real-time feedback with inline error messages
- **Search Functionality**: Quick filtering of itineraries
- **Tab-Based Detail View**: Easy switching between timeline and budget views

### 3. Error Handling: Application effectively manages and communicates errors to users

**Validation System:**
- **Input Validation**: Real-time validation for required fields
- **Error Messages**: Clear, user-friendly error descriptions in red text
- **Prevention**: Prevents saving with invalid data
- **Recovery**: Easy correction of errors with clear guidance

**Error Types Handled:**
- Empty destination validation
- Plan field validation (title, category-specific details)
- Amount validation (negative values rejected, zero allowed)
- Date range validation

### 4. Testing and Debugging: Unit tests ensure key functionalities work as intended

**Comprehensive UI Testing:**
- **Core Functionality**: Creating, editing, deleting itineraries
- **Plan Management**: Adding plans with different categories
- **Validation Testing**: Error handling and input validation
- **Navigation Testing**: Flow between different views
- **Search Testing**: Filtering and clearing search results
- **Empty State Testing**: Handling when no data exists

**Test Coverage:**
- 15+ UI test methods covering all major user flows
- Edge case testing (empty states, validation errors)
- Cross-platform compatibility testing

### 5. Version Control Usage: Proper use of Git for version control

**Git Best Practices:**
- **Clear Commit History**: Descriptive commit messages for each feature
- **Feature Branches**: Organized development workflow
- **Code Reviews**: Systematic review process for changes
- **Documentation**: README and code comments for maintainability

### 6. Documentation: Source code documentation highlights OOP and protocol-oriented design principles

**Code Documentation:**
- **Inline Comments**: Explaining complex logic and design decisions
- **Architecture Documentation**: Clear explanation of inheritance hierarchy
- **Protocol Documentation**: Interface contracts and usage examples
- **Component Documentation**: Reusable component usage and props

**Design Principles Highlighted:**
- **Inheritance**: Budget class hierarchy with specialized subclasses
- **Protocols**: Codable, Identifiable, and custom ItineraryProtocol
- **Encapsulation**: Private properties with controlled access
- **Polymorphism**: Uniform handling of different budget types

---

**Author**: Taejun Seo 
**Course**: Advanced iOS Development - Assignment 2  
**University**: University of Technology Sydney
