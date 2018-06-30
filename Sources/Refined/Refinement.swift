
public protocol Refinement {
    associatedtype RefinedType

    static func passes(_ value: RefinedType) -> Bool
}

public enum Both<R1: Refinement, R2: Refinement>: Refinement where R1.RefinedType == R2.RefinedType {
    public typealias RefinedType = R1.RefinedType

    public static func passes(_ value: R1.RefinedType) -> Bool {
        return R1.passes(value) && R2.passes(value)
    }
}

public enum OneOf<R1: Refinement, R2: Refinement>: Refinement where R1.RefinedType == R2.RefinedType {
    public typealias RefinedType = R1.RefinedType

    public static func passes(_ value: R1.RefinedType) -> Bool {
        return R1.passes(value) || R2.passes(value)
    }
}

public extension Refinement {
    static func of(_ value: RefinedType) -> Refined<RefinedType, Self>? {
        return Refined<RefinedType, Self>(value)
    }
}
