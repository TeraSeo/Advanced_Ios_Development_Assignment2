import XCTest
@testable import Assignment2

final class Assignment2Tests: XCTestCase {
    
    // Itinerary Tests
    
    func testItineraryNumberOfDays() throws {
        let start = Date()
        let end = Calendar.current.date(byAdding: .day, value: 5, to: start)!
        let itinerary = Itinerary(destination: "Sydney", startDate: start, endDate: end)
        
        XCTAssertEqual(itinerary.numberOfDays, 5, "Itinerary should calculate correct number of days")
    }
    
    func testItineraryTotalBudget() throws {
        let plan1 = Plan(
            title: "Hotel Stay",
            time: Date(),
            budget: AccommodationBudget(amount: 200, hotelName: "Hilton"),
            categorySpecificDetail: "Hilton"
        )
        let plan2 = Plan(
            title: "Dinner",
            time: Date(),
            budget: FoodDrinkBudget(amount: 50, restaurantName: "Sushi Bar"),
            categorySpecificDetail: "Sushi Bar"
        )
        
        let itinerary = Itinerary(
            destination: "Tokyo",
            startDate: Date(),
            endDate: Date().addingTimeInterval(86400),
            plans: [plan1, plan2]
        )
        
        XCTAssertEqual(itinerary.totalBudget, 250, "Total budget should be the sum of all plan budgets")
    }
    
    func testItineraryBudgetBreakdown() throws {
        let plan = Plan(
            title: "Flight",
            time: Date(),
            budget: TransportBudget(amount: 300, transportType: "Plane"),
            categorySpecificDetail: "Plane"
        )
        
        let itinerary = Itinerary(
            destination: "New York",
            startDate: Date(),
            endDate: Date().addingTimeInterval(86400),
            plans: [plan]
        )
        
        let breakdown = itinerary.budgetBreakdown
        XCTAssertEqual(breakdown[.transport], 300, "Transport budget should be correctly calculated in breakdown")
    }
    
    // Plan Tests
    
    func testPlanPurposeMatchesBudgetCategory() throws {
        let budget = FoodDrinkBudget(amount: 30, restaurantName: "Cafe")
        let plan = Plan(title: "Lunch", time: Date(), budget: budget, categorySpecificDetail: "Cafe")
        
        XCTAssertEqual(plan.purpose, "Food & Drink", "Plan purpose should match budget category raw value")
    }
    
    // Budget Subclass Tests
    
    func testAccommodationBudgetInitialization() throws {
        let budget = AccommodationBudget(amount: 500, hotelName: "Sheraton")
        
        XCTAssertEqual(budget.amount, 500, "Accommodation budget should keep correct amount")
        XCTAssertEqual(budget.hotelName, "Sheraton", "Accommodation budget should store hotel name")
        XCTAssertEqual(budget.category, .accommodation, "Category should be set to .accommodation")
    }
    
    func testFoodDrinkBudgetInitialization() throws {
        let budget = FoodDrinkBudget(amount: 40, restaurantName: "McDonald's")
        
        XCTAssertEqual(budget.amount, 40)
        XCTAssertEqual(budget.restaurantName, "McDonald's")
        XCTAssertEqual(budget.category, .foodAndDrink)
    }
    
    func testTransportBudgetInitialization() throws {
        let budget = TransportBudget(amount: 120, transportType: "Train")
        
        XCTAssertEqual(budget.amount, 120)
        XCTAssertEqual(budget.transportType, "Train")
        XCTAssertEqual(budget.category, .transport)
    }
    
    func testExtrasBudgetInitialization() throws {
        let budget = ExtrasBudget(amount: 75, description: "Museum tickets")
        
        XCTAssertEqual(budget.amount, 75)
        XCTAssertEqual(budget.description, "Museum tickets")
        XCTAssertEqual(budget.category, .extras)
    }
    
    // Encoding & Decoding Tests
    
    func testItineraryEncodingAndDecoding() throws {
        let plan = Plan(
            title: "Dinner",
            time: Date(),
            budget: FoodDrinkBudget(amount: 60, restaurantName: "Italian Bistro"),
            categorySpecificDetail: "Italian Bistro"
        )
        
        let itinerary = Itinerary(
            destination: "Rome",
            startDate: Date(),
            endDate: Date().addingTimeInterval(86400),
            plans: [plan]
        )
        
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        let data = try encoder.encode(itinerary)
        let decoded = try decoder.decode(Itinerary.self, from: data)
        
        XCTAssertEqual(decoded.destination, "Rome", "Decoded itinerary should match encoded one")
        XCTAssertEqual(decoded.plans.first?.title, "Dinner", "Decoded plan should match encoded one")
    }
}
