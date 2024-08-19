//
//  DessertsAppTests.swift
//  DessertsAppTests
//
//  Created by Trey Browder on 8/16/24.
//

import XCTest
@testable import DessertsApp

final class DessertsAppTests: XCTestCase {

    func testDecodeDessertMealCount() throws {
        do {
            let dessert = try JSONDecoder().decode(Dessert.self, from: testDessertData)
            let mealCount = dessert.meals.count
            XCTAssertTrue(mealCount > 0)
            XCTAssertTrue(mealCount == 10)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

}
