import XCTest
@testable import PetToxic

final class PetToxicTests: XCTestCase {

    override func setUpWithError() throws {
        // Setup code before each test
    }

    override func tearDownWithError() throws {
        // Cleanup code after each test
    }

    // MARK: - Model Tests

    func testToxicItemCreation() throws {
        let item = ToxicItem.sample

        XCTAssertFalse(item.name.isEmpty)
        XCTAssertFalse(item.categories.isEmpty)
        XCTAssertFalse(item.symptoms.isEmpty)
        XCTAssertFalse(item.speciesRisks.isEmpty)
    }

    func testSeverityColors() throws {
        XCTAssertNotNil(Severity.low.color)
        XCTAssertNotNil(Severity.moderate.color)
        XCTAssertNotNil(Severity.high.color)
        XCTAssertNotNil(Severity.severe.color)
    }

    func testCategoryDisplayNames() throws {
        for category in Category.allCases {
            XCTAssertFalse(category.displayName.isEmpty)
            XCTAssertFalse(category.icon.isEmpty)
        }
    }

    func testSpeciesDisplayNames() throws {
        for species in Species.allCases {
            XCTAssertFalse(species.displayName.isEmpty)
            XCTAssertFalse(species.icon.isEmpty)
        }
    }

    // MARK: - Database Tests

    func testDatabaseServiceReturnsItems() throws {
        let items = DatabaseService.shared.allToxicItems()
        XCTAssertFalse(items.isEmpty)
    }

    func testDatabaseSearchFindsItems() throws {
        let results = DatabaseService.shared.search(query: "chocolate", species: nil)
        XCTAssertFalse(results.isEmpty)
        XCTAssertTrue(results.contains { $0.name.lowercased().contains("chocolate") })
    }

    func testDatabaseSearchWithSpeciesFilter() throws {
        let results = DatabaseService.shared.search(query: "lily", species: [.cat])
        XCTAssertFalse(results.isEmpty)
    }

    func testDatabaseCategoryFilter() throws {
        let foodItems = DatabaseService.shared.items(for: .foods)
        XCTAssertFalse(foodItems.isEmpty)

        for item in foodItems {
            XCTAssertTrue(item.categories.contains(.foods))
        }
    }

    // MARK: - Search Result Tests

    func testSearchResultCreation() throws {
        let item = ToxicItem.sample
        let result = SearchResult(item: item, relevanceScore: 100.0, matchType: .exact)

        XCTAssertEqual(result.id, item.id)
        XCTAssertEqual(result.relevanceScore, 100.0)
        XCTAssertEqual(result.matchType, .exact)
    }
}
