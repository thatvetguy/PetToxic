import XCTest

final class PetToxicUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    // MARK: - Tab Navigation Tests

    func testTabBarExists() throws {
        XCTAssertTrue(app.tabBars.buttons["Search"].exists)
        XCTAssertTrue(app.tabBars.buttons["Browse"].exists)
        XCTAssertTrue(app.tabBars.buttons["Saved"].exists)
        XCTAssertTrue(app.tabBars.buttons["Emergency"].exists)
    }

    func testTabNavigation() throws {
        app.tabBars.buttons["Browse"].tap()
        XCTAssertTrue(app.navigationBars["Browse"].exists)

        app.tabBars.buttons["Saved"].tap()
        XCTAssertTrue(app.navigationBars["Saved"].exists)

        app.tabBars.buttons["Emergency"].tap()
        XCTAssertTrue(app.navigationBars["Emergency"].exists)

        app.tabBars.buttons["Search"].tap()
        XCTAssertTrue(app.navigationBars["Search"].exists)
    }

    // MARK: - Search Tests

    func testSearchBarExists() throws {
        XCTAssertTrue(app.searchFields.firstMatch.exists)
    }

    func testSearchFlow() throws {
        let searchField = app.searchFields.firstMatch
        searchField.tap()
        searchField.typeText("chocolate")

        // Wait for results
        let predicate = NSPredicate(format: "exists == true")
        let cell = app.cells.firstMatch
        expectation(for: predicate, evaluatedWith: cell, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
    }

    // MARK: - Emergency Screen Tests

    func testEmergencyContactsExist() throws {
        app.tabBars.buttons["Emergency"].tap()

        XCTAssertTrue(app.staticTexts["Contact Poison Control"].exists)
        XCTAssertTrue(app.staticTexts["(888) 426-4435"].exists || app.buttons["ASPCA Animal Poison Control"].exists)
    }

    // MARK: - Browse Tests

    func testBrowseCategoriesExist() throws {
        app.tabBars.buttons["Browse"].tap()

        // Check that at least some category cells exist
        XCTAssertTrue(app.cells.count > 0)
    }
}
