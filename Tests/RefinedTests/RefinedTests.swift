
@testable import Refined
import XCTest

enum Positive: Refinement {
    typealias RefinedType = Int

    static func passes(_ value: Int) -> Bool {
        return value > 0
    }
}

enum LessThan100: Refinement {
    typealias RefinedType = Int

    static func passes(_ value: Int) -> Bool {
        return value < 100
    }
}

final class RefinedTests: XCTestCase {
    func testPositiveInteger() {
        XCTAssertNotNil(
            Positive.of(90)
        )

        XCTAssertNil(
            Positive.of(-22)
        )
    }

    func testLessThan100() {
        XCTAssertNotNil(
            LessThan100.of(99)
        )

        XCTAssertNil(
            LessThan100.of(1000)
        )
    }

    func testBothRefinements() {
        XCTAssertNotNil(
            Both<Positive, LessThan100>.of(99)
        )

        XCTAssertNil(
            Both<Positive, LessThan100>.of(-1)
        )

        XCTAssertNil(
            Both<Positive, LessThan100>.of(1000)
        )
    }

    func testOneOfRefinements() {
        XCTAssertNotNil(
            OneOf<ProvidedFirstName, ProvidedLastName>.of(
                Person(firstName: "foo", lastName: "")
            )
        )

        XCTAssertNotNil(
            OneOf<ProvidedFirstName, ProvidedLastName>.of(
                Person(firstName: "", lastName: "foo")
            )
        )

        XCTAssertNotNil(
            OneOf<ProvidedFirstName, ProvidedLastName>.of(
                Person(firstName: "foo", lastName: "bar")
            )
        )

        XCTAssertNil(
            OneOf<ProvidedFirstName, ProvidedLastName>.of(
                Person(firstName: "", lastName: "")
            )
        )
    }
}

private struct Person {
    let firstName: String

    let lastName: String
}

private enum ProvidedFirstName: Refinement {
    typealias RefinedType = Person

    static func passes(_ value: Person) -> Bool {
        return !value.firstName.isEmpty
    }
}

private enum ProvidedLastName: Refinement {
    typealias RefinedType = Person

    static func passes(_ value: Person) -> Bool {
        return !value.lastName.isEmpty
    }
}
