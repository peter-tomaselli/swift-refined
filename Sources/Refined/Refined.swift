
public struct Refined<A, R: Refinement> where A == R.RefinedType {
    public let value: A

    public init?(_ value: A) {
        guard R.passes(value) else { return nil }
        self.value = value
    }
}

extension Refined: Equatable where A: Equatable {
    public static func ==(_ lhs: Refined, _ rhs: Refined) -> Bool {
        return lhs.value == rhs.value
    }
}

extension Refined: Hashable where A: Hashable {
    public var hashValue: Int {
        return value.hashValue
    }
}
